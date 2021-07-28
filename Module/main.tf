provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "groupon" 
  name     = "groupon-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "groupon" {
  name                = "groupon-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.groupon.location
  resource_group_name = azurerm_resource_group.groupon.name
}

resource "azurerm_subnet" "groupon" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.groupon.name
  virtual_network_name = azurerm_virtual_network.groupon.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "groupon" {
  name                = "groupon-nic"
  location            = azurerm_resource_group.groupon.location
  resource_group_name = azurerm_resource_group.groupon.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.groupon.id
    private_ip_address_allocation = "Dynamic"
  }
}