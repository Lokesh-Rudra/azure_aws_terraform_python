terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "139c2828-520b-4cef-8b8d-f9f74767e04f"
  client_id ="ee594b1c-adfa-4782-bb43-e8496851a159"
  client_secret = "8EX8Q~1pGHPmJPjF2tmP91X1kt_rmguZ2fhuacXK"
  tenant_id = "897685b7-16fb-4c95-9b5e-15984b6571c1"
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.rgname}"
  location = "${var.rglocation}"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "terraform-vnet1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}