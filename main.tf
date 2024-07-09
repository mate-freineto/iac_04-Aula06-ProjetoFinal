resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

# Gerar grupo de recursos
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}
# Criar Rede Virtual
resource "azurerm_virtual_network" "acme_vnet" {
  name                = "acme-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
# Criar SubNet para Servidores Backend
resource "azurerm_subnet" "acme_subnet" {
  name                 = "acme-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.acme_vnet.name
  address_prefixes     = ["10.1.0.0/24"]
}


resource "azurerm_public_ip" "pubIP_web" {
   count               = "${length(var.server_web)}"
   name                = "publicIP_${var.server_web[count.index]}_${count.index}"
   location            = azurerm_resource_group.rg.location
   resource_group_name = azurerm_resource_group.rg.name
   allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "pubIP_db" {
   count               = "${length(var.server_db)}"
   name                = "publicIP_${var.server_db[count.index]}_${count.index}"
   location            = azurerm_resource_group.rg.location
   resource_group_name = azurerm_resource_group.rg.name
   allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "nsg_web" {
  name                = "networkSecurityGroup_web"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_network_security_group" "nsg_db" {
  name                = "networkSecurityGroup_db"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}