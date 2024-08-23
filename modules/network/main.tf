locals {
  resource_group_name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)

}
locals {
  subnet_types = tomap( {

    for k,s in var.subnets : k => split("_", s.name)[0]
  }

  )
}
locals {
    nsg_types = {
        for k, ty in local.local.subnet_types : k => try(var.nsg_types[ty], null)
    }
  
}

resource "azurerm_virtual_network" "vnet" {
    name                = format("%s-%s-vnet", var.owner_custom, var.purpose_custom)
    location            = var.location
    resource_group_name = var.resource_group_name
    address_space       = var.address_space
  
}

resource "azurerm_subnet" "subnet" {
    for_each = var.subnets
    name                 = each.value.name
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [each.value.address_prefix]
    service_endpoints    = each.value.service_endpoints
    nsg_name             = local.nsg_types[each.value.name]
  
}