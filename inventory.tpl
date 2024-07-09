web:
  hosts:
  %{ for vm in vms_web ~}
  ${vm.name}:
      ansible_host: ${vm.public_ip_address}
  %{ endfor ~}
vars:
    ansible_user: ${username}
db:
  hosts:
  %{ for vm in vms_db ~}
  ${vm.name}:
      ansible_host: ${vm.public_ip_address}
  %{ endfor ~}
vars:
    ansible_user: ${username}