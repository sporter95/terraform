terraform {
   backend "azurerm" {
      resource_group_name  = "sporter-rg-EUS"
      storage_account_name = "sporterblobacct"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
    }
}