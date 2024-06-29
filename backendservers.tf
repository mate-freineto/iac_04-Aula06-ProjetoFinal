# Create network interface
resource "azurerm_network_interface" "my_vm_nic" {

  count = "${var.vm_linux_number}" 
  name                = "myNicVM${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "nicVM1Configuration"
    subnet_id                     = azurerm_subnet.my_backend_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Adiciona VM* no Address pool
resource "azurerm_network_interface_backend_address_pool_association" "my_nic_vm_addresspool" {
  count = "${var.vm_linux_number}" 
  network_interface_id    = azurerm_network_interface.my_vm_nic[count.index].id
  ip_configuration_name   = "nicVM1Configuration"
  backend_address_pool_id = azurerm_lb_backend_address_pool.my_backend_pool.id
}

# Conecta NSG com VM*
resource "azurerm_network_interface_security_group_association" "net_nsg_vm" {
  count = "${var.vm_linux_number}" 
  network_interface_id      = azurerm_network_interface.my_vm_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.my_nsg.id
}

# Gera texto randomico para storage
resource "random_id" "random_vm_id" {
  count = "${var.vm_linux_number}"
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }
  byte_length = 8
}

# Cria conta storage VM* pra diagnosticar boot
resource "azurerm_storage_account" "my_vm_storage_account" {
  
  count = "${var.vm_linux_number}"
  name                     = "diag${random_id.random_vm_id[count.index].hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_pet" "azurerm_linux_virtual_machine_name" {
  prefix = "vm"
}

# Cria VM1
resource "azurerm_linux_virtual_machine" "my_vm" {

  count = "${var.vm_linux_number}" 

  name                  = "${random_pet.azurerm_linux_virtual_machine_name.id}${count.index}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.my_vm_nic[count.index].id]
  size                  = "Standard_DS1_v2"
  os_disk {
    name                 = "myVM1OsDisk${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "${random_pet.azurerm_linux_virtual_machine_name.id}${count.index}"
  admin_username = var.username
  admin_ssh_key {
    username   = var.username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_vm_storage_account[count.index].primary_blob_endpoint
  }

  depends_on = [ azurerm_network_interface.my_vm_nic ]

}
