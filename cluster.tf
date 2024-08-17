# Databricks provider
provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.example.id
}

# Create Databricks Serverless Cluster
resource "databricks_cluster" "serverless" {
  cluster_name            = var.cluster_name
  spark_version           = var.spark_version
  node_type_id            = "Standard_E4s_v3" # Choose appropriate node type
  autotermination_minutes = 30
  spark_conf = {
    "spark.databricks.cluster.profile" = "serverless"
    "spark.databricks.repl.allowedLanguages" = "python,sql"
  }
  num_workers             = 2

  custom_tags = {
    "Environment" = "Development"
    "Owner"       = "Vinod"
  }
}
