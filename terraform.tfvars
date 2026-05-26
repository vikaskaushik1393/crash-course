storage_accounts = {
  sa1 = {
    name                     = "stgeaaus"
    resource_group_name      = "eaaus"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
storage_container = {
  sc1 = {
    name                  = "vhdeaacontainer"
    storage_account_id    = "sa1"
    container_access_type = "private"
  }
}