Set up or verify Databricks environment for: $ARGUMENTS

Databricks setup checklist:

1. **Verify prerequisites**
   - Check Databricks CLI is installed and configured
   - Verify Unity Catalog access
   - Confirm necessary permissions

2. **Catalog structure setup**
   - Review `databricks/setup_catalog_structure.py`
   - Create catalog: `dispute_agent_demo`
   - Set up schemas:
     * `raw_data` (Bronze layer)
     * `processed_data` (Silver layer) 
     * `vector_search` (ML/AI layer)
     * `analytics` (Gold layer)
   - Create volumes for document storage

3. **Data ingestion**
   - Review `databricks/upload_data.py`
   - Upload CSV data to `raw_data.dispute_records`
   - Upload PDF policy to volume
   - Verify data loaded correctly

4. **Vector search setup**
   - Review `databricks/create_vector_index.py`
   - Create chunks table for policy documents
   - Set up embedding endpoint (databricks-bge-large-en)
   - Create vector search index
   - Test vector search functionality

5. **RAG model deployment**
   - Review `databricks/dispute_guideline_rag_model_updated.py`
   - Register model with MLflow
   - Create serving endpoint
   - Test endpoint with sample queries

6. **Validation**
   - Query dispute records table
   - Test vector search with sample query
   - Verify RAG model responses
   - Check all components are connected

7. **Documentation update**
   - Update configuration in CLAUDE.md if needed
   - Document any environment-specific settings
   - Note any issues or workarounds

Output summary:
- ✅ Components successfully set up
- ⚠️ Warnings or considerations
- ❌ Any failures requiring attention
- Next steps or recommendations

