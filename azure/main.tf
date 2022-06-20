# Azure Provider source and version being used
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
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
}

terraform {
  backend "azurerm" {
    storage_account_name = "azurebackend987654321"
    container_name       = "terraformbackend123"
    key                  = "test.terraform.tfstate"
    access_key = "vV3OQQxAZcTxjv9bDyPNgE4DOdDgvnK+LnZqO4iWQnW2/NzhE6jTmRH0UelC2jZBjA9LL30vWtPe+ASt+QXXAg=="
  }
}


resource "azurerm_resource_group" "rg1" {
name = "vnettest"
location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "$(var.prefix)"
  location            = "$(azurerm_resource_group.rg.location)"
  resource_group_name = "$(azurerm_resource_group.rg.name)"
  address_space       = ["$(var.vnet_cidr_prefix)"]
}

