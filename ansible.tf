# Gerar um inventario das VMs
resource "local_file" "hosts_cfg" {
  content = templatefile("inventory.tpl",
    {
      vms_web      = azurerm_linux_virtual_machine.acmeVM_web
      vms_db      = azurerm_linux_virtual_machine.acmeVM_db
      username = var.username
    }
  )
  filename = "./ansible/inventory.yml"
}
