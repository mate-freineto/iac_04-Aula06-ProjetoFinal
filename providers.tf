terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-aula06-projetofinal"
    storage_account_name = "storageaula06"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

  }

}

provider "azurerm" {
  features {

  }
}
