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
variable "appname" {  
  type = string
  default = "myapp"
  
}
variable "env" {
  type = string
  default = "dev"
  
}

locals {
  resource_group_name = "${var.appname}-rg-${var.env}"
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_group_name}"
  location = "southcentralus"
}

# creat virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.appname}-vnet-${var.env}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}
# create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.appname}-subnet-${var.env}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/24"]
}