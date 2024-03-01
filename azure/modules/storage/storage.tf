


resource "azurerm_storage_account" "sporter-blob-acct" {
  name                     = "sporterblobacct"
  resource_group_name      = var.rg_name
  location                 = var.rg_loc
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "terraform" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sporter-blob-acct.name
  container_access_type = "private"
}

