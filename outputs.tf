output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.student-vm.public_ip_address}"
}

output "linux_virtual_machine_names" {
  value = azurerm_linux_virtual_machine.student-vm.name
}

output "vm_private_ip_address" {
   value = "${azurerm_linux_virtual_machine.student-vm.private_ip_address}"
}
