terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.35.0"
    }
  }
}

provider "cloudflare" {
  #api_token = var.cloudflare_api_token
}