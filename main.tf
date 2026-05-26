resource "azurerm_resource_group" "eaaus" {
  for_each = var.storage_accounts
  name     = each.value.resource_group_name
  location = each.value.location
}
resource "azurerm_storage_account" "eaausstorage" {
  for_each                 = var.storage_accounts
  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.eaaus[each.key].name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}
resource "azurerm_storage_container" "eaauscontainer" {
  for_each              = var.storage_container
  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.eaausstorage["sa1"].id
  container_access_type = each.value.container_access_type
}
resource "azurerm_virtual_network" "eaausvnet" {
  name                = "eaausvnet"
  address_space       = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.eaaus["sa1"].name
  location            = azurerm_resource_group.eaaus["sa1"].location
}
resource "azurerm_subnet" "eaaussubnet" {
  name                 = "eaaussubnet"
  resource_group_name  = azurerm_resource_group.eaaus["sa1"].name
  virtual_network_name = azurerm_virtual_network.eaausvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}   