terraform { 
  cloud { 
    
    organization = "devops_vv" 

    workspaces { 
      name = "devops-dev" 
    } 
  }
  
   
}


terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.0.0"
    }
  }
}
provider "azurerm" {
  features {}
}

provider "databricks" {
  azure_workspace_resource_id = data.azurerm_databricks_workspace.this.id

}

variable "databricks_workspace_name" {
  description = "databricks-dev"
  default = "databricks-dev"
}

variable "cluster_name" {
  description = "The name of the Databricks cluster."
  default     = "my-databricks-cluster"
}

variable "spark_version" {
  description = "The version of Apache Spark."
  default     = "11.3.x-scala2.12"
}

variable "node_type_id" {
  description = "The type of nodes to use in the cluster."
  default     = "Standard_D3_v2"
}

variable "num_workers" {
  description = "The number of worker nodes in the cluster."
  default     = 2
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "tfc-storage-rg"
  location = "southcentralus"
}

##  Demo now
resource "azurerm_storage_account" "StorageAccountDemo" {
  name                     = "tfcdev"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    video = "azure"
    channel = "CloudQuickLabs"
  }
}

resource "azurerm_databricks_workspace" "example" {
  name                = var.databricks_workspace_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "premium"

  tags = {
    Environment = "dev"
  }
}

data "azurerm_databricks_workspace" "example" {
  name                = var.databricks_workspace_name
  resource_group_name = azurerm_resource_group.rg.name
}

# Create the Databricks cluster
resource "databricks_cluster" "example" {
  cluster_name            = var.cluster_name
  spark_version           = var.spark_version
  node_type_id            = var.node_type_id
  autotermination_minutes = 60
  num_workers             = var.num_workers

  custom_tags = {
    "Environment" = "dev"
    "Owner"       = "Vinod"
  }
}

# Output the cluster ID
output "cluster_id" {
  value = databricks_cluster.example.id
}
