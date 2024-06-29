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
   subscription_id = "f2903193-bd0d-461c-ba93-573f3e78434d"
   tenant_id       = "14cbd5a7-ec94-46ba-b314-cc0fc972a161"
}
