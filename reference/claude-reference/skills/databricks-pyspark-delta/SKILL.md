---
name: databricks-pyspark-delta
description: Expert guidance for Databricks development including PySpark DataFrame operations, Delta Lake patterns, medallion architecture (Bronze/Silver/Gold layers), performance optimization, and Databricks-specific best practices. Use when working with Databricks notebooks, Spark DataFrames, Delta tables, or building data pipelines.
---

# Databricks PySpark & Delta Lake Development Guide

## Overview

This skill provides comprehensive patterns and best practices for developing on Databricks, including PySpark operations, Delta Lake management, and the medallion architecture pattern.

---

## Core PySpark Patterns

### DataFrame Creation and Reading

**Read from various sources:**
```python
# Read CSV
df = spark.read.format("csv") \
    .option("header", "true") \
    .option("inferSchema", "true") \
    .load("/path/to/file.csv")

# Read Delta table
df = spark.read.format("delta").load("/path/to/delta/table")
# Or use table name
df = spark.table("catalog.schema.table_name")

# Read Parquet
df = spark.read.parquet("/path/to/parquet")

# Read JSON
df = spark.read.json("/path/to/json")
```

### DataFrame Transformations

**Common operations:**
```python
# Select columns
df_selected = df.select("col1", "col2", "col3")

# Filter rows
df_filtered = df.filter(df.age > 21)
# Or use SQL-style
df_filtered = df.filter("age > 21")

# Add computed columns
from pyspark.sql.functions import col, when, lit
df_with_new_col = df.withColumn(
    "age_group",
    when(col("age") < 18, "minor")
    .when(col("age") < 65, "adult")
    .otherwise("senior")
)

# Rename columns
df_renamed = df.withColumnRenamed("old_name", "new_name")

# Drop columns
df_dropped = df.drop("col1", "col2")

# Aggregations
df_agg = df.groupBy("category").agg(
    count("*").alias("count"),
    avg("price").alias("avg_price"),
    sum("quantity").alias("total_quantity")
)

# Joins
df_joined = df1.join(df2, df1.id == df2.user_id, "left")
# Or using column names
df_joined = df1.join(df2, "id", "inner")
```

### Window Functions

```python
from pyspark.sql.window import Window
from pyspark.sql.functions import row_number, rank, dense_rank, lag, lead

# Define window
window_spec = Window.partitionBy("category").orderBy(col("date").desc())

# Apply window functions
df_with_row_num = df.withColumn("row_num", row_number().over(window_spec))
df_with_prev = df.withColumn("prev_value", lag("value", 1).over(window_spec))
```

---

## Delta Lake Operations

### Creating and Writing Delta Tables

```python
# Write DataFrame as Delta table
df.write.format("delta") \
    .mode("overwrite") \
    .save("/path/to/delta/table")

# Write with partitioning
df.write.format("delta") \
    .mode("overwrite") \
    .partitionBy("date", "region") \
    .save("/path/to/delta/table")

# Create managed table
df.write.format("delta") \
    .mode("overwrite") \
    .saveAsTable("catalog.schema.table_name")

# Append data
df.write.format("delta") \
    .mode("append") \
    .save("/path/to/delta/table")
```

### MERGE Operations (Upserts)

```python
from delta.tables import DeltaTable

# Load target Delta table
target_table = DeltaTable.forPath(spark, "/path/to/delta/table")
# Or by name
target_table = DeltaTable.forName(spark, "catalog.schema.table_name")

# Perform MERGE
target_table.alias("target").merge(
    source_df.alias("source"),
    "target.id = source.id"  # Merge condition
).whenMatchedUpdate(
    condition="source.updated_at > target.updated_at",  # Optional condition
    set={
        "value": "source.value",
        "updated_at": "source.updated_at"
    }
).whenNotMatchedInsert(
    values={
        "id": "source.id",
        "value": "source.value",
        "updated_at": "source.updated_at"
    }
).execute()

# Delete matching rows
target_table.alias("target").merge(
    source_df.alias("source"),
    "target.id = source.id"
).whenMatchedDelete().execute()
```

### Delta Lake Time Travel

```python
# Read historical version by timestamp
df_historical = spark.read.format("delta") \
    .option("timestampAsOf", "2024-01-01 00:00:00") \
    .load("/path/to/delta/table")

# Read by version number
df_version = spark.read.format("delta") \
    .option("versionAsOf", 5) \
    .load("/path/to/delta/table")

# View table history
from delta.tables import DeltaTable
delta_table = DeltaTable.forPath(spark, "/path/to/delta/table")
history_df = delta_table.history()
display(history_df)
```

### Delta Lake Optimization

```python
# OPTIMIZE - compact small files
spark.sql("OPTIMIZE catalog.schema.table_name")

# Z-ORDER - co-locate related data
spark.sql("OPTIMIZE catalog.schema.table_name ZORDER BY (column1, column2)")

# VACUUM - remove old files
spark.sql("VACUUM catalog.schema.table_name RETAIN 168 HOURS")  # 7 days

# Programmatic optimization
from delta.tables import DeltaTable
delta_table = DeltaTable.forPath(spark, "/path/to/delta/table")
delta_table.optimize().executeCompaction()
delta_table.optimize().executeZOrderBy("column1", "column2")
```

---

## Medallion Architecture (Bronze/Silver/Gold)

### Bronze Layer - Raw Data Ingestion

**Purpose:** Store raw, unprocessed data exactly as received from source

```python
# Bronze layer - raw ingestion
def ingest_to_bronze(source_path, bronze_path):
    """
    Ingest raw data into Bronze layer with minimal transformation.
    Add audit columns: ingestion_timestamp, source_file
    """
    from pyspark.sql.functions import current_timestamp, input_file_name
    
    df_raw = spark.read.format("json").load(source_path)
    
    df_bronze = df_raw \
        .withColumn("ingestion_timestamp", current_timestamp()) \
        .withColumn("source_file", input_file_name())
    
    df_bronze.write.format("delta") \
        .mode("append") \
        .save(bronze_path)
    
    return df_bronze

# Usage
bronze_df = ingest_to_bronze("/source/data/*.json", "/bronze/raw_events")
```

### Silver Layer - Cleaned and Validated

**Purpose:** Clean, validate, and standardize data; remove duplicates

```python
def process_bronze_to_silver(bronze_path, silver_path):
    """
    Transform Bronze to Silver:
    - Parse and validate data types
    - Remove duplicates
    - Handle nulls and invalid data
    - Standardize formats
    """
    from pyspark.sql.functions import to_timestamp, col
    
    df_bronze = spark.read.format("delta").load(bronze_path)
    
    # Clean and validate
    df_silver = df_bronze \
        .filter(col("id").isNotNull()) \
        .withColumn("event_date", to_timestamp(col("event_timestamp"))) \
        .dropDuplicates(["id"]) \
        .select(
            "id",
            "user_id",
            "event_type",
            "event_date",
            "value",
            "ingestion_timestamp"
        )
    
    # Write to Silver with MERGE
    from delta.tables import DeltaTable
    
    if DeltaTable.isDeltaTable(spark, silver_path):
        silver_table = DeltaTable.forPath(spark, silver_path)
        silver_table.alias("target").merge(
            df_silver.alias("source"),
            "target.id = source.id"
        ).whenMatchedUpdateAll() \
         .whenNotMatchedInsertAll() \
         .execute()
    else:
        df_silver.write.format("delta").save(silver_path)
    
    return df_silver

# Usage
silver_df = process_bronze_to_silver("/bronze/raw_events", "/silver/clean_events")
```

### Gold Layer - Business-Level Aggregates

**Purpose:** Create business-ready aggregates, metrics, and features

```python
def create_gold_aggregates(silver_path, gold_path):
    """
    Create Gold layer aggregates for analytics and ML:
    - Business-level metrics
    - Pre-computed aggregations
    - Feature engineering
    """
    from pyspark.sql.functions import sum, avg, count, max as spark_max
    
    df_silver = spark.read.format("delta").load(silver_path)
    
    # Create daily user metrics
    df_gold = df_silver.groupBy(
        "user_id",
        to_date("event_date").alias("date")
    ).agg(
        count("*").alias("event_count"),
        sum("value").alias("total_value"),
        avg("value").alias("avg_value"),
        spark_max("event_date").alias("last_event_time")
    )
    
    # Write to Gold
    df_gold.write.format("delta") \
        .mode("overwrite") \
        .partitionBy("date") \
        .save(gold_path)
    
    # Create as table
    df_gold.write.format("delta") \
        .mode("overwrite") \
        .saveAsTable("gold.user_daily_metrics")
    
    return df_gold

# Usage
gold_df = create_gold_aggregates("/silver/clean_events", "/gold/user_metrics")
```

---

## Performance Optimization Best Practices

### Caching and Persistence

```python
# Cache for iterative operations
df_cached = df.cache()
# Use it multiple times
df_cached.count()
df_cached.show()

# Unpersist when done
df_cached.unpersist()

# Persist with storage level
from pyspark import StorageLevel
df.persist(StorageLevel.MEMORY_AND_DISK)
```

### Broadcast Joins for Small Tables

```python
from pyspark.sql.functions import broadcast

# Broadcast small dimension table
df_result = large_fact_table.join(
    broadcast(small_dimension_table),
    "key_column"
)
```

### Partition Pruning

```python
# Filter on partition columns early
df_filtered = df.filter("date >= '2024-01-01' AND region = 'US'")

# When writing, partition strategically
df.write.format("delta") \
    .partitionBy("date", "region") \
    .save("/path")
```

### Avoid Shuffles When Possible

```python
# BAD - causes shuffle
df.repartition(100)

# GOOD - use coalesce to reduce partitions without shuffle
df.coalesce(10)

# Repartition only when needed (e.g., before writes)
df.repartition(200, "partition_column").write.format("delta").save("/path")
```

---

## Databricks-Specific Features

### Widgets for Parameterization

```python
# Create widgets
dbutils.widgets.text("start_date", "2024-01-01", "Start Date")
dbutils.widgets.dropdown("environment", "prod", ["dev", "staging", "prod"])

# Get widget values
start_date = dbutils.widgets.get("start_date")
env = dbutils.widgets.get("environment")

# Remove widgets
dbutils.widgets.removeAll()
```

### Working with dbutils

```python
# File system operations
dbutils.fs.ls("/mnt/data")
dbutils.fs.cp("/source/path", "/dest/path", recurse=True)
dbutils.fs.rm("/path/to/delete", recurse=True)

# Secrets management
api_key = dbutils.secrets.get(scope="my-scope", key="api-key")

# Notebook workflow
dbutils.notebook.run("/path/to/notebook", timeout_seconds=300, arguments={"param": "value"})
dbutils.notebook.exit("success")
```

### Unity Catalog Best Practices

```python
# Use three-level namespace
spark.sql("USE CATALOG production")
spark.sql("USE SCHEMA analytics")

# Query with full path
df = spark.table("production.analytics.user_events")

# Grant permissions (for admins)
spark.sql("GRANT SELECT ON TABLE catalog.schema.table TO `user@domain.com`")
spark.sql("GRANT ALL PRIVILEGES ON SCHEMA catalog.schema TO `group-name`")
```

---

## Common Patterns and Anti-Patterns

### ✅ DO: Use Structured Streaming for Incremental Processing

```python
# Read stream from Delta
stream_df = spark.readStream.format("delta").table("bronze.raw_events")

# Process stream
processed_df = stream_df.filter(col("valid") == True)

# Write stream to Delta
query = processed_df.writeStream \
    .format("delta") \
    .outputMode("append") \
    .option("checkpointLocation", "/checkpoints/silver_events") \
    .table("silver.processed_events")
```

### ❌ DON'T: Read entire table when you only need recent data

```python
# BAD
df = spark.table("huge_table")
df_recent = df.filter("date >= '2024-01-01'")

# GOOD - push down filter
df_recent = spark.table("huge_table").filter("date >= '2024-01-01'")
```

### ✅ DO: Use SQL for complex transformations

```python
# Mix Python and SQL as appropriate
spark.sql("""
    CREATE OR REPLACE TEMP VIEW user_summary AS
    SELECT 
        user_id,
        COUNT(*) as event_count,
        SUM(value) as total_value,
        MAX(event_date) as last_event
    FROM silver.events
    WHERE date >= '2024-01-01'
    GROUP BY user_id
""")

df = spark.table("user_summary")
```

---

## Error Handling and Debugging

```python
# Add try-catch for production robustness
from pyspark.sql.utils import AnalysisException

try:
    df = spark.table("catalog.schema.table")
except AnalysisException as e:
    print(f"Table not found: {e}")
    # Create table or handle error

# Use explain to understand query plans
df.explain(mode="extended")

# Check execution plan
df.explain()

# Display sample data
display(df.limit(10))
```

---

## Testing Patterns

```python
# Unit test example for transformation function
def test_process_events():
    # Create test data
    test_data = [(1, "user1", "2024-01-01"), (2, "user2", "2024-01-02")]
    test_df = spark.createDataFrame(test_data, ["id", "user_id", "date"])
    
    # Apply transformation
    result_df = process_events(test_df)
    
    # Assert results
    assert result_df.count() == 2
    assert "processed_date" in result_df.columns

# Integration test with sample Delta table
def integration_test():
    test_path = "/tmp/test_delta_table"
    
    # Write test data
    test_df.write.format("delta").mode("overwrite").save(test_path)
    
    # Run pipeline
    result = process_pipeline(test_path)
    
    # Verify
    assert result.count() > 0
    
    # Cleanup
    dbutils.fs.rm(test_path, recurse=True)
```

---

## Key Takeaways

1. **Always use Delta Lake format** for ACID transactions and time travel
2. **Follow medallion architecture** (Bronze → Silver → Gold) for data quality
3. **Optimize with Z-ORDER** on commonly filtered columns
4. **Use MERGE for upserts** instead of overwrite when updating data
5. **Partition strategically** on date/time columns for query performance
6. **Cache DataFrames** only when reusing them multiple times
7. **Use broadcast joins** for small dimension tables
8. **Leverage Unity Catalog** for governance and security
9. **Monitor with OPTIMIZE and VACUUM** regularly
10. **Test transformations** with sample data before production runs
