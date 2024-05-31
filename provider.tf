#provider with version - 3.104.0 
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.104.0"
    }
  }
}
provider "azurerm" {
  features {}
}