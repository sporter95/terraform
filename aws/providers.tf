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
  }
}

provider "godaddy" {
  # Configuration options
}