terraform { 
  cloud { 
    
    organization = "devops_vv" 

    workspaces { 
      name = "devops-dev" 
    } 
  } 
}

provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "tfc-storage-rg"
  location = "your-location"
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "tfc-storage-account-dev"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account tier             = "Standard"
  account_replication_type = "LRS"
}
