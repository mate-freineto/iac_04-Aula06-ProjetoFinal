
resource "random_id" "random_vm_id_web" {
  count = "${length(var.server_web)}"
  keepers = {
    resource_group = azurerm_resource_group.rg.name
  }
  byte_length = 8
}

resource "azurerm_storage_account" "my_vm_storage_account_web" {
  
  count = "${length(var.server_web)}"
  name                     = "diag${random_id.random_vm_id_web[count.index].hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_id" "random_vm_id_db" {
  count = "${length(var.server_db)}"
  keepers = {
    resource_group = azurerm_resource_group.rg.name
  }
  byte_length = 8
}


resource "azurerm_storage_account" "my_vm_storage_account_db" {
  
  count = "${length(var.server_db)}"
  name                     = "diag${random_id.random_vm_id_db[count.index].hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

