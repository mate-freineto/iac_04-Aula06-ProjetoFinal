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
}

provider "azurerm" {
  features {

  }
}
