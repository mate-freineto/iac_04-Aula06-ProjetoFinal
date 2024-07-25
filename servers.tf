
resource "azurerm_linux_virtual_machine" "student-vm" {

  name                  = "student-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic_student.id]
  size                  = "Standard_DS1_v2"
  os_disk {
    name                 = "Vstudent-vm_Disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "student-vm"
  admin_username = var.username
  admin_password = var.vm_admin_password
  admin_ssh_key {
    username   = var.username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_vm_storage_account_student.primary_blob_endpoint
  }

  depends_on = [ azurerm_network_interface_security_group_association.nicNSG_student ]

}
