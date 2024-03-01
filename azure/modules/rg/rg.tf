resource "azurerm_resource_group" "sporter-rg-EUS" {
  name     = "sporter-rg-EUS"
  location = "East US"
}

output "rg_eus_name" {
       value = azurerm_resource_group.sporter-rg-EUS.name
} 

output "rg_eus_loc" {
       value = azurerm_resource_group.sporter-rg-EUS.location
} 

output "rg_eus_id" {
       value = azurerm_resource_group.sporter-rg-EUS.id
}
 
