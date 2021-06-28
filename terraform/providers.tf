terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.65.0"
    }
    healthchecksio = {
      source  = "kristofferahl/healthchecksio"
      version = "1.9.0"
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
