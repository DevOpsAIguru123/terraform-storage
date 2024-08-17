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

##  Demo now
resource "azurerm_storage_account" "StorageAccountDemo" {
  name                     = "tfc-storage-account-dev"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    video = "azure"
    channel = "CloudQuickLabs"
  }
}
