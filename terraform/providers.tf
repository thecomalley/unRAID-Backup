terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    healthchecksio = {
      source = "kristofferahl/healthchecksio"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "healthchecksio" {
  api_key = var.healthchecksio_api_key
}
