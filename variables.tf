variable "az_subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}


variable "az_tenant_id" {
  description = "The Azure Tenant ID"
  type        = string
}

variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Local do grupo de recursos"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefixo para o grupo de recursos que vai ser combinado com um nome randomico."
}

variable "username" {
  type        = string
  description = "O usuario que vai ser usado pra acessar a VM."
  default     = "acmeadmin"
}

variable "vm_linux_number" {
  type        = number
  description = "Total de VM Linux."
  default     = 2
}

variable "vm_prefix" {
  type        = string
  description = "Prexifo utilizado para a criação de VM"
  default     = "acmeVM"
}

variable server_web {
  type = list
  default = ["acmeVM1"]
}

variable server_db {
  type = list(string)
  default = ["acmeVM2"]
}