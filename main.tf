terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "728a4094-1648-4ee9-b7f6-2c509c6b5a68"
  client_id       = "fd3809b9-07d4-4fff-9a72-bb2f3c966958"
  client_secret   = "rdS8Q~.7nwFlyhjL07urS3BzaF9_UEYPVOJBxc4K"
  tenant_id       = "36591f76-8672-4875-9ddb-9de77b3204db"
}


resource "azurerm_resource_group" "example" {
  name     = "LoadBalancerNS"
  location = "West Europe"
}

resource "azurerm_public_ip" "example" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "example" {
  name                = "TestLoadBalancer"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}
