# Generate inventory file
resource "local_file" "inventory" {
  filename = "./ansible/inventory.ini"
  content  = <<EOF
[webserver]
${azurerm_linux_virtual_machine.student-vm.public_ip_address}

[webserver:vars]
ansible_user=${var.username}
EOF
}
