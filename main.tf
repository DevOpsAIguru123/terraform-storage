# Required providers
provider "azurerm" {
}

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.0.0"
    }
  }
}

# Resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Databricks Workspace
resource "azurerm_databricks_workspace" "example" {
  name                = var.databricks_workspace_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "premium" # Choose the appropriate SKU (e.g., standard, premium)
}

# Output the workspace URL
output "workspace_url" {
  value = azurerm_databricks_workspace.example.workspace_url
}
