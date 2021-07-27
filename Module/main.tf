provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "groupon" 
  name     = "groupon-rg"
  location = "eastus"
}