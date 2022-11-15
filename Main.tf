terraform {
  required_providers {
 
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
}

provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg-atividade" {
  name     = "rg-atividade"
  location = "westus2"
}
resource "azurerm_kubernetes_cluster" "aks-atividade" {
  name                = "aks-atividade"
  location            = azurerm_resource_group.rg-atividade.location
  resource_group_name = azurerm_resource_group.rg-atividade.name
  dns_prefix          = "aks-atividade"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
