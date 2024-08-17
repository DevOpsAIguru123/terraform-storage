variable "resource_group_name" {
  description = "The name of the resource group."
  default = "terraform-dbx"
}

variable "location" {
  description = "The Azure region for the resources."
  default     = "southcentralus"
}

variable "databricks_workspace_name" {
  description = "The name of the Databricks workspace."
  default = "terraform-dbx-dev"
}



variable "cluster_name" {
  description = "The name of the Databricks cluster."
  default     = "my-serverless-cluster"
}

variable "spark_version" {
  description = "The version of Apache Spark."
  default     = "11.3.x-scala2.12"
}
