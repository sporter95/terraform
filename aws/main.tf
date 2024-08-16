provider "aws" {
  region = "us-east-1" 
  #access_key = "your_access_key"
  #secret_key = "your_secret_key"
}
module "budget" {
  source = "./modules/budget"
}

module "iam" {
  source = "./modules/iam"
}

module "k8s" {
  source = "./modules/k8s"
  subnet1-id = "${module.network.subnet1-id}"
  subnet2-id = "${module.network.subnet2-id}"
}

module "network" {
  source = "./modules/network"
}

resource "cloudflare_record" "sporter-info-www" {
    zone_id = var.cf_zone_id
    name = "www"
    type = "CNAME"
    content = "main.d3i6jv5757vx1b.amplifyapp.com"
    
}

