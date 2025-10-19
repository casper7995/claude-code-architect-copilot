---
name: mlflow-deployment
description: Complete guide for MLflow experiment tracking, model registry, deployment patterns, and ML operations on Databricks. Covers experiment logging, model versioning, A/B testing, and production deployment workflows. Use when tracking ML experiments, managing model lifecycle, or deploying models to production.
---

# MLflow & Model Deployment Guide

## Overview

This skill provides comprehensive patterns for MLflow-based experiment tracking, model management, and deployment workflows, with specific focus on Databricks integration.

---

## MLflow Experiment Tracking

### Basic Experiment Logging

```python
import mlflow
import mlflow.sklearn
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, f1_score

# Set experiment
mlflow.set_experiment("/Users/username/my-ml-experiment")

# Start a run
with mlflow.start_run(run_name="random_forest_v1"):
    # Train model
    model = RandomForestClassifier(n_estimators=100, max_depth=10, random_state=42)
    model.fit(X_train, y_train)
    
    # Make predictions
    y_pred = model.predict(X_test)
    
    # Calculate metrics
    accuracy = accuracy_score(y_test, y_pred)
    f1 = f1_score(y_test, y_pred, average='weighted')
    
    # Log parameters
    mlflow.log_param("n_estimators", 100)
    mlflow.log_param("max_depth", 10)
    mlflow.log_param("random_state", 42)
    
    # Log metrics
    mlflow.log_metric("accuracy", accuracy)
    mlflow.log_metric("f1_score", f1)
    
    # Log model
    mlflow.sklearn.log_model(model, "model")
    
    print(f"Run ID: {mlflow.active_run().info.run_id}")
```

### Advanced Experiment Tracking

```python
import mlflow
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay

with mlflow.start_run(run_name="experiment_with_artifacts"):
    # Train model
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)
    
    # Log multiple parameters at once
    params = {
        "n_estimators": 100,
        "max_depth": 10,
        "min_samples_split": 5,
        "min_samples_leaf": 2,
        "algorithm": "RandomForest"
    }
    mlflow.log_params(params)
    
    # Log multiple metrics at once
    metrics = {
        "train_accuracy": accuracy_score(y_train, model.predict(X_train)),
        "test_accuracy": accuracy_score(y_test, y_pred),
        "f1_score": f1_score(y_test, y_pred, average='weighted')
    }
    mlflow.log_metrics(metrics)
    
    # Log confusion matrix as artifact
    cm = confusion_matrix(y_test, y_pred)
    disp = ConfusionMatrixDisplay(confusion_matrix=cm)
    disp.plot()
    plt.savefig("confusion_matrix.png")
    mlflow.log_artifact("confusion_matrix.png")
    plt.close()
    
    # Log feature importance
    import pandas as pd
    feature_importance = pd.DataFrame({
        'feature': X_train.columns,
        'importance': model.feature_importances_
    }).sort_values('importance', ascending=False)
    
    feature_importance.to_csv("feature_importance.csv", index=False)
    mlflow.log_artifact("feature_importance.csv")
    
    # Log data schema
    schema = {
        "features": list(X_train.columns),
        "target": "churn",
        "num_samples": len(X_train)
    }
    mlflow.log_dict(schema, "data_schema.json")
    
    # Log model with signature and input example
    from mlflow.models.signature import infer_signature
    signature = infer_signature(X_train, model.predict(X_train))
    
    mlflow.sklearn.log_model(
        model,
        "model",
        signature=signature,
        input_example=X_train.iloc[:5]
    )
```

### Nested Runs for Hyperparameter Tuning

```python
import mlflow
from sklearn.model_selection import ParameterGrid

# Parent run for the entire tuning experiment
with mlflow.start_run(run_name="hyperparameter_tuning"):
    
    param_grid = {
        'n_estimators': [50, 100, 200],
        'max_depth': [10, 20, None]
    }
    
    best_score = 0
    best_params = None
    
    # Child runs for each parameter combination
    for params in ParameterGrid(param_grid):
        with mlflow.start_run(nested=True, run_name=f"run_{params}"):
            # Train model
            model = RandomForestClassifier(**params, random_state=42)
            model.fit(X_train, y_train)
            
            # Evaluate
            score = accuracy_score(y_test, model.predict(X_test))
            
            # Log to child run
            mlflow.log_params(params)
            mlflow.log_metric("accuracy", score)
            
            if score > best_score:
                best_score = score
                best_params = params
    
    # Log best results to parent run
    mlflow.log_params(best_params)
    mlflow.log_metric("best_accuracy", best_score)
```

---

## MLflow Model Registry

### Registering Models

```python
import mlflow

# Register model during training
with mlflow.start_run():
    model.fit(X_train, y_train)
    
    mlflow.sklearn.log_model(
        model,
        "model",
        registered_model_name="customer_churn_model"
    )

# Or register an existing run
run_id = "abc123def456"
model_uri = f"runs:/{run_id}/model"
mlflow.register_model(model_uri, "customer_churn_model")
```

### Model Versioning and Stages

```python
from mlflow.tracking import MlflowClient

client = MlflowClient()

# Get model versions
versions = client.search_model_versions("name='customer_churn_model'")

# Transition model to staging
client.transition_model_version_stage(
    name="customer_churn_model",
    version=1,
    stage="Staging"
)

# Transition to production
client.transition_model_version_stage(
    name="customer_churn_model",
    version=1,
    stage="Production",
    archive_existing_versions=True  # Archive previous production versions
)

# Add description/tags
client.update_model_version(
    name="customer_churn_model",
    version=1,
    description="Random Forest model trained on Q4 2024 data"
)

client.set_model_version_tag(
    name="customer_churn_model",
    version=1,
    key="validation_status",
    value="approved"
)
```

### Loading Models from Registry

```python
import mlflow.pyfunc

# Load latest version from staging
model = mlflow.pyfunc.load_model("models:/customer_churn_model/Staging")

# Load specific version
model = mlflow.pyfunc.load_model("models:/customer_churn_model/1")

# Load production model
model = mlflow.pyfunc.load_model("models:/customer_churn_model/Production")

# Make predictions
predictions = model.predict(X_test)
```

---

## Databricks-Specific MLflow Patterns

### Using Databricks Experiment UI

```python
# In Databricks notebook
import mlflow

# Experiment is automatically created for each notebook
# Or set a custom experiment
mlflow.set_experiment("/Shared/my-team/churn-prediction")

with mlflow.start_run():
    # Your training code
    model.fit(X_train, y_train)
    
    # Log everything
    mlflow.log_params(params)
    mlflow.log_metrics(metrics)
    mlflow.sklearn.log_model(model, "model")
    
    # Display run in notebook
    displayHTML(f"""
        <a href="#mlflow/experiments/{mlflow.active_run().info.experiment_id}/runs/{mlflow.active_run().info.run_id}">
            View Run in MLflow UI
        </a>
    """)
```

### Autologging in Databricks

```python
import mlflow

# Enable autologging for supported frameworks
mlflow.autolog()

# Train - automatically logs params, metrics, and model
from sklearn.ensemble import RandomForestClassifier
model = RandomForestClassifier(n_estimators=100)
model.fit(X_train, y_train)

# Autolog also works with:
# - XGBoost
# - LightGBM
# - TensorFlow/Keras
# - PyTorch
# - Spark MLlib

# Disable autologging
mlflow.autolog(disable=True)
```

### Tracking Data Lineage

```python
import mlflow

with mlflow.start_run():
    # Log dataset info
    dataset_info = {
        "source_table": "catalog.schema.raw_events",
        "date_range": "2024-01-01 to 2024-12-31",
        "num_records": len(df),
        "features": list(X_train.columns)
    }
    mlflow.log_dict(dataset_info, "dataset_info.json")
    
    # Log data quality metrics
    mlflow.log_metric("missing_values_pct", df.isnull().sum().sum() / df.size)
    mlflow.log_metric("duplicate_records", df.duplicated().sum())
    
    # Train and log model
    model.fit(X_train, y_train)
    mlflow.sklearn.log_model(model, "model")
```

---

## Model Deployment Patterns

### Batch Scoring with MLflow Model

```python
import mlflow
import pandas as pd

# Load production model
model = mlflow.pyfunc.load_model("models:/customer_churn_model/Production")

# Load data to score
df_to_score = spark.table("catalog.schema.customers_to_score")
X = df_to_score.toPandas()[feature_columns]

# Make predictions
predictions = model.predict(X)

# Add predictions back to dataframe
df_to_score = df_to_score.withColumn("churn_prediction", predictions)

# Save results
df_to_score.write.format("delta") \
    .mode("overwrite") \
    .saveAsTable("catalog.schema.customer_predictions")
```

### Model Serving via REST API (Databricks)

```python
# Register model
with mlflow.start_run():
    mlflow.sklearn.log_model(
        model,
        "model",
        registered_model_name="customer_churn_model"
    )

# Transition to Production
from mlflow.tracking import MlflowClient
client = MlflowClient()
client.transition_model_version_stage(
    name="customer_churn_model",
    version=1,
    stage="Production"
)

# Enable model serving (through Databricks UI or API)
# Then call the endpoint:
import requests
import os

url = "https://your-workspace.databricks.com/serving-endpoints/customer_churn_model/invocations"
headers = {
    "Authorization": f"Bearer {os.environ.get('DATABRICKS_TOKEN')}",
    "Content-Type": "application/json"
}

data = {
    "dataframe_records": [
        {"feature1": 10, "feature2": 20, "feature3": 30},
        {"feature1": 15, "feature2": 25, "feature3": 35}
    ]
}

response = requests.post(url, headers=headers, json=data)
predictions = response.json()
```

### Creating a Custom MLflow Model (pyfunc)

```python
import mlflow
import pandas as pd

class CustomChurnModel(mlflow.pyfunc.PythonModel):
    """Custom model with preprocessing and business logic"""
    
    def load_context(self, context):
        """Load model and any artifacts"""
        import joblib
        self.model = joblib.load(context.artifacts["model"])
        self.scaler = joblib.load(context.artifacts["scaler"])
        self.feature_names = joblib.load(context.artifacts["features"])
    
    def predict(self, context, model_input):
        """Custom prediction logic"""
        # Preprocess
        X = model_input[self.feature_names]
        X_scaled = self.scaler.transform(X)
        
        # Predict probability
        proba = self.model.predict_proba(X_scaled)[:, 1]
        
        # Apply business rules
        predictions = []
        for p in proba:
            if p > 0.8:
                risk = "high"
            elif p > 0.5:
                risk = "medium"
            else:
                risk = "low"
            predictions.append({"probability": p, "risk_category": risk})
        
        return pd.DataFrame(predictions)

# Save artifacts
import joblib
joblib.dump(model, "model.pkl")
joblib.dump(scaler, "scaler.pkl")
joblib.dump(feature_names, "features.pkl")

# Log custom model
artifacts = {
    "model": "model.pkl",
    "scaler": "scaler.pkl",
    "features": "features.pkl"
}

with mlflow.start_run():
    mlflow.pyfunc.log_model(
        artifact_path="custom_model",
        python_model=CustomChurnModel(),
        artifacts=artifacts,
        registered_model_name="custom_churn_model"
    )
```

---

## A/B Testing and Model Monitoring

### A/B Test Framework

```python
import mlflow
import random

# Load two model versions
model_a = mlflow.pyfunc.load_model("models:/churn_model/1")  # Current
model_b = mlflow.pyfunc.load_model("models:/churn_model/2")  # New

def ab_predict(features, user_id):
    """Route 50% of traffic to each model"""
    # Use user_id for consistent routing
    if hash(user_id) % 2 == 0:
        prediction = model_a.predict(features)
        model_version = "A"
    else:
        prediction = model_b.predict(features)
        model_version = "B"
    
    # Log prediction for analysis
    log_prediction(user_id, prediction, model_version)
    
    return prediction, model_version

# Collect metrics to compare models
def analyze_ab_test():
    """Compare model performance in production"""
    from pyspark.sql.functions import avg, count
    
    results = spark.sql("""
        SELECT 
            model_version,
            COUNT(*) as predictions,
            AVG(actual_outcome) as conversion_rate,
            AVG(prediction_confidence) as avg_confidence
        FROM prediction_logs
        WHERE date >= current_date - 7
        GROUP BY model_version
    """)
    
    display(results)
```

### Model Performance Monitoring

```python
import mlflow
from datetime import datetime, timedelta

def monitor_model_performance(model_name, days=7):
    """Monitor production model metrics over time"""
    
    # Get predictions and actuals from last N days
    end_date = datetime.now()
    start_date = end_date - timedelta(days=days)
    
    df = spark.sql(f"""
        SELECT 
            date,
            prediction,
            actual,
            ABS(prediction - actual) as error
        FROM production_predictions
        WHERE model_name = '{model_name}'
        AND date BETWEEN '{start_date}' AND '{end_date}'
    """).toPandas()
    
    # Calculate metrics
    from sklearn.metrics import mean_squared_error, mean_absolute_error
    
    mse = mean_squared_error(df['actual'], df['prediction'])
    mae = mean_absolute_error(df['actual'], df['prediction'])
    
    # Log monitoring metrics
    with mlflow.start_run(run_name=f"monitoring_{datetime.now().date()}"):
        mlflow.log_metric("production_mse", mse)
        mlflow.log_metric("production_mae", mae)
        mlflow.log_metric("num_predictions", len(df))
        
        # Alert if metrics degrade
        if mse > THRESHOLD:
            mlflow.log_param("alert", "Model performance degraded")
            send_alert(f"Model {model_name} MSE: {mse}")
    
    return mse, mae
```

---

## Model Versioning Best Practices

### Semantic Versioning for Models

```python
def version_model(model_name, major, minor, patch):
    """
    Semantic versioning for ML models:
    - MAJOR: Breaking API changes or algorithm changes
    - MINOR: New features, backward compatible
    - PATCH: Bug fixes, retraining on new data
    """
    version_tag = f"v{major}.{minor}.{patch}"
    
    with mlflow.start_run():
        mlflow.log_param("semantic_version", version_tag)
        # ... log model ...
        
        result = mlflow.register_model(
            f"runs:/{mlflow.active_run().info.run_id}/model",
            model_name
        )
        
        # Tag with semantic version
        client = MlflowClient()
        client.set_model_version_tag(
            model_name,
            result.version,
            "semantic_version",
            version_tag
        )

# Example: Bug fix in preprocessing
version_model("churn_model", major=1, minor=2, patch=1)
```

### Model Documentation

```python
import mlflow
from datetime import datetime

def document_model(model_name, version, info):
    """Add comprehensive documentation to model"""
    client = MlflowClient()
    
    description = f"""
# {model_name} v{version}

## Purpose
{info.get('purpose', 'N/A')}

## Training Data
- Source: {info.get('data_source', 'N/A')}
- Date Range: {info.get('date_range', 'N/A')}
- Samples: {info.get('num_samples', 'N/A')}

## Model Details
- Algorithm: {info.get('algorithm', 'N/A')}
- Key Parameters: {info.get('key_params', 'N/A')}
- Training Date: {datetime.now().date()}

## Performance
- Validation Accuracy: {info.get('accuracy', 'N/A')}
- F1 Score: {info.get('f1', 'N/A')}

## Deployment
- Approved By: {info.get('approved_by', 'N/A')}
- Approval Date: {info.get('approval_date', 'N/A')}

## Known Issues
{info.get('known_issues', 'None')}
    """
    
    client.update_model_version(
        name=model_name,
        version=version,
        description=description
    )

# Usage
info = {
    'purpose': 'Predict customer churn for retention campaigns',
    'data_source': 'catalog.analytics.customer_features',
    'date_range': '2023-01-01 to 2024-12-31',
    'num_samples': 100000,
    'algorithm': 'Random Forest',
    'key_params': 'n_estimators=200, max_depth=15',
    'accuracy': 0.87,
    'f1': 0.85,
    'approved_by': 'Data Science Team',
    'approval_date': '2024-10-15',
    'known_issues': 'Performs poorly on new customer segment'
}

document_model("customer_churn_model", 3, info)
```

---

## Common Patterns and Anti-Patterns

### ✅ DO: Log model signature

```python
from mlflow.models.signature import infer_signature

# Infer from training data
signature = infer_signature(X_train, model.predict(X_train))

mlflow.sklearn.log_model(
    model,
    "model",
    signature=signature,
    input_example=X_train.iloc[:5]
)
```

### ✅ DO: Use consistent naming conventions

```python
# Good naming
mlflow.set_experiment("/Shared/ds-team/customer-churn-prediction")

with mlflow.start_run(run_name="rf_v2_tuned_2024-10-15"):
    # training code
    pass
```

### ❌ DON'T: Log sensitive data

```python
# BAD - don't log PII or sensitive data
mlflow.log_param("customer_emails", customer_emails)  # ❌

# GOOD - log aggregates or anonymized info
mlflow.log_param("num_customers", len(customer_emails))  # ✅
```

### ✅ DO: Clean up old artifacts

```python
# Delete runs older than 90 days
from mlflow.tracking import MlflowClient
from datetime import datetime, timedelta

client = MlflowClient()
experiment = client.get_experiment_by_name("/Shared/my-experiment")

cutoff_date = datetime.now() - timedelta(days=90)
runs = client.search_runs(experiment.experiment_id)

for run in runs:
    if run.info.start_time < cutoff_date.timestamp() * 1000:
        client.delete_run(run.info.run_id)
```

---

## Databricks Workflows Integration

### Schedule Model Retraining

```python
# Create a Databricks job that runs this notebook weekly
# Notebook: train_and_deploy.py

import mlflow
from datetime import datetime

# Set experiment
mlflow.set_experiment("/Shared/weekly-model-training")

with mlflow.start_run(run_name=f"weekly_training_{datetime.now().date()}"):
    # Load latest data
    df = spark.table("catalog.analytics.training_data")
    
    # Train model
    model = train_model(df)
    
    # Evaluate
    metrics = evaluate_model(model, X_test, y_test)
    mlflow.log_metrics(metrics)
    
    # If metrics are good, register and promote
    if metrics['accuracy'] > 0.85:
        result = mlflow.sklearn.log_model(
            model,
            "model",
            registered_model_name="customer_churn_model"
        )
        
        # Promote to Staging for validation
        client = MlflowClient()
        client.transition_model_version_stage(
            name="customer_churn_model",
            version=result.version,
            stage="Staging"
        )
        
        print(f"New model version {result.version} promoted to Staging")
    else:
        print("Model did not meet performance threshold")
```

---

## Key Takeaways

1. **Always log experiments** - Track params, metrics, and artifacts for reproducibility
2. **Use Model Registry** for version control and staging
3. **Implement monitoring** to detect model drift and performance degradation
4. **Document models thoroughly** for team collaboration and compliance
5. **Use semantic versioning** to communicate changes clearly
6. **Automate retraining** with scheduled jobs
7. **Test models in Staging** before Production deployment
8. **Log model signatures** for input validation
9. **Use autologging** when available to reduce boilerplate
10. **Monitor A/B tests** carefully before full rollout
