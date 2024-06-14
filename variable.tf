#Infra information
variable "owner" {
  description = "solar-owner"
  type        = string
  default     = "solar"
}
variable "environment" {
  description = "solar-environment"
  type        = string
  default     = "secure"
}
#Resource Group Variables
variable "rg_name" {
  description = "resource-gp-name"
  type        = string
  default     = "rg"
}
variable "location" {
  description = "resource-location"
  type        = string
  default     = "uksouth"
}
#Window Virtual Machine variables
variable "win_vm_name" {
  description = "win-vm-name"
  type        = string
  default     = "vm"
}
variable "win_vm_username" {
  description = "win-vm-username"
  type        = string
  default     = "adminuser"
}
variable "win_vm_password" {
  description = "win-vm-password"
  type        = string
  default     = "P@$$w0rd1234!"
}
#Network security group for database 
variable "db_nsg" {
  description = "nsg-db-name"
  type        = string
  default     = "newtork-sec-gp-db"
}
variable "nsg_db_subnet" {
  description = "nsg-db-subnet-nmae"
  type        = string
  default     = "subnet"
}
variable "db_nsrule" {
  description = "db-network-sec-rule-name"
  type        = string
  default     = "network-sec-rule"
}
variable "this_mysql_fs" {
  description = "mysql flexible server name"
  type        = string
  default     = "mysql-flexible-server"
}
variable "this_flexible_database" {
  description = "flexible database name"
  type        = string
  default     = "flexible-database"
}
variable "flexible_db_username" {
  description = "flexible database admin login username"
  type        = string
  default     = "psqladmin"
}
variable "virtual_network" {
  description = "virtual network name"
  type        = string
  default     = "vnet"
}
variable "network_subnet" {
  description = "network-subnet"
  type        = string
  default     = "subnet"
}
variable "network_nic" {
  description = "network interface card"
  type        = string
  default     = "nic"
}
variable "key_vault" {
  description = "keyvault name"
  type        = string
  default     = "kv"
}
variable "kv_subnet" {
  description = "keyvault subnet name"
  type        = string
  default     = "kv-subnet"
}
variable "kv_private_subnet" {
  description = "keyvault subnet name"
  type        = string
  default     = "kv-subnet"
}
variable "db_subnet" {
  description = "db subnet"
  type        = string
  default     = "db-subnet"
}
variable "db_private_endpoint" {
  description = "db priavte endpoint name"
  type        = string
  default     = "db-privateendpoint"
}
variable "db_nsg" {
  description = "database network security group name"
  type        = string
  default     = "db-nsg"
}
variable "vm_secret" {
  description = "vm secret keyvault name"
  type        = string
  default     = "vm-secret"
}
variable "flexible_server_secret" {
  description = "msql felxible secret keyvault name"
  type        = string
  default     = "msql-flexible-server-secret"
}
variable "bastion_public_ip" {
  description = "azure bashion public ip name"
  type        = string
  default     = "Azure-bashion-public-ip"
}
variable "bastion_host" {
  description = "azure bashion host name"
  type        = string
  default     = "bastion-host"
}
variable "db_private_dns_group" {
  description = "db private dns group name"
  type        = string
  default     = "db-private-dns-group"
}
variable "db_private_dns_zone" {
  description = "db private dns zone name"
  type        = string
  default     = "db-private-dns-zone"
}
variable "db_private_dns_vnet_link" {
  description = "db private dns vnet link name"
  type        = string
  default     = "db-private-dns-vnet-link"
}
variable "db_private_service_connection" {
  description = "db private dns service connection name"
  type        = string
  default     = "db-private-service-connection"
}
variable "kv_private_service_connection" {
  description = "private_service_connection"
  type        = string
  default     = "secure-privateserviceconnection"
}
variable "vm_nsg_subnet" {
  description = "nsg vm subnet name"
  type        = string
  default     = "nsg-vm_subnet"
}
variable "vm_nsg" {
  description = "vm network security group name"
  type        = string
  default     = "vm_nsg"
}
variable "vm_nsrule" {
  description = "vm nsrule name"
  type        = string
  default     = "vm-nsrule-name"
  }
variable "network_vm_nic" {
  description = "vm network interface card"
  type        = string
  default     = "vm-network-interface-card"
  }
  variable "bastion_nsrule" {
  description = "bastion network security rule name"
  type        = string
  default     = "bastion-nsrule"
  }