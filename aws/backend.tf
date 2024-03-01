terraform {
  backend "s3" {
    bucket         	   = "sporter-tfstate"
    key                = "main/terraform.tfstate"
    region         	   = "us-east-1"
    
  }
}