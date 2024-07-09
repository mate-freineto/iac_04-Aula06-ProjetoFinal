
resource "azurerm_linux_virtual_machine" "acmeVM_web" {

  count = "${length(var.server_web)}" 

  name                  = "${var.server_web[count.index]}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vm_nic_web[count.index].id]
  size                  = "Standard_DS1_v2"
  os_disk {
    name                 = "VM1OsDisk_${var.server_web[count.index]}"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "${var.server_web[count.index]}"
  admin_username = var.username
  admin_ssh_key {
    username   = var.username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_vm_storage_account_web[count.index].primary_blob_endpoint
  }

  depends_on = [ azurerm_network_interface_security_group_association.nicNSG_web ]

}


resource "azurerm_linux_virtual_machine" "acmeVM_db" {

  count = "${length(var.server_db)}" 

  name                  = "${var.server_db[count.index]}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vm_nic_db[count.index].id]
  size                  = "Standard_DS1_v2"
  os_disk {
    name                 = "VM1OsDisk_${var.server_db[count.index]}"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "${var.server_db[count.index]}"
  admin_username = var.username
  admin_ssh_key {
    username   = var.username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_vm_storage_account_db[count.index].primary_blob_endpoint
  }

  depends_on = [ azurerm_network_interface_security_group_association.nicNSG_db ]

}