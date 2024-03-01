terraform {
  required_providers {
    godaddy = {
      source = "n3integration/godaddy"
      #version = "1.9.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.35.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      #version = "=3.0.0"
    }    
  }
}

provider "godaddy" {
  # Configuration options
}

provider "azurerm" {
  features{}
}