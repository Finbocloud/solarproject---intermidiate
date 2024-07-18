#Network security Group for database
/* resource "azurerm_subnet" "this_vmnsg_subnet" {
  name                 = "${local.owner}-${var.vm_nsg_subnet}-${local.environment}"
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.11.0/24"]
} */
resource "azurerm_network_interface" "this_vm_nic" {
  name                = "${local.owner}-${var.network_vm_nic}-${local.environment}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.9"
    #The first 1-4 Ip address are reserved so start from 10.0.11.5 and above 5
  }
}

resource "azurerm_network_security_group" "this_vm_nsg" {
  name                = "${local.owner}-${var.vm_nsg}-${local.environment}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
}

resource "azurerm_network_security_rule" "this_mysqloutbound_nsrule" {
  name                       = "${local.owner}-${var.vm_nsrule}-${local.environment}"
  priority                   = 100
  direction                  = "Outbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "3306"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = azurerm_private_endpoint.this_db_private_endpoint.private_service_connection[0].private_ip_address
  # [0] in line 37 means it should grab the first IP address of the private endpoint
  resource_group_name         = azurerm_resource_group.this_rg.name
  network_security_group_name = azurerm_network_security_group.this_vm_nsg.name
}

resource "azurerm_network_security_rule" "this_bastion_nsrule" {
  name                        = "${local.owner}-${var.bastion_nsrule}-${local.environment}"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.this_rg.name
  network_security_group_name = azurerm_network_security_group.this_vm_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "this_vm_network_security_group_association" {
  subnet_id                 = azurerm_subnet.this_subnet.id
  network_security_group_id = azurerm_network_security_group.this_vm_nsg.id
}