resource "azurerm_network_interface" "vm_nic_web" {
  count               = "${length(var.server_web)}"
  name                = "nic-${var.server_web[count.index]}_${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic_${var.server_web[count.index]}${count.index}_configuration"
    subnet_id                     = azurerm_subnet.acme_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubIP_web[count.index].id
  }
}

resource "azurerm_network_interface_security_group_association" "nicNSG_web" {
  count                     = "${length(var.server_web)}"
  network_interface_id      = azurerm_network_interface.vm_nic_web[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg_web.id
}

resource "azurerm_network_interface" "vm_nic_db" {
  count               = "${length(var.server_db)}"
  name                = "nic-${var.server_db[count.index]}_${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic_${var.server_db[count.index]}${count.index}_configuration"
    subnet_id                     = azurerm_subnet.acme_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubIP_db[count.index].id
  }
}

resource "azurerm_network_interface_security_group_association" "nicNSG_db" {
  count                     = "${length(var.server_db)}"
  network_interface_id      = azurerm_network_interface.vm_nic_db[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg_db.id
}
