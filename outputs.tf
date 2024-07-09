output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "public_ip_address_web" {
  value = azurerm_public_ip.pubIP_web.*.ip_address
}
output "public_ip_address_db" {
  value = azurerm_public_ip.pubIP_db.*.ip_address
}
output "linux_virtual_machine_names_web" {
  value = [for s in azurerm_linux_virtual_machine.acmeVM_web : s.name[*]]
}
output "linux_virtual_machine_names_db" {
  value = [for s in azurerm_linux_virtual_machine.acmeVM_db : s.name[*]]
}

output "vm_private_ip_address_web" {
   value = "${azurerm_linux_virtual_machine.acmeVM_web.*.private_ip_address}"
}

output "vm_private_ip_address_db" {
   value = "${azurerm_linux_virtual_machine.acmeVM_db.*.private_ip_address}"
}