variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Local do grupo de recursos"
}

variable "resource_group_name" {
  type        = string
  default     = "student-rg"
  description = "Nome do grupo de recursos"
}

variable "username" {
  type        = string
  description = "O usuario que vai ser usado pra acessar a VM."
  default     = "azureuser"
}

variable "vm_admin_password" {
  type = string
}
