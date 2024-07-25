resource "azurerm_network_interface" "nic_student" {
  name                = "nic_student"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic_student_configuration"
    subnet_id                     = azurerm_subnet.student-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.student-pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nicNSG_student" {
  network_interface_id      = azurerm_network_interface.nic_student.id
  network_security_group_id = azurerm_network_security_group.student-nsg.id
}
