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
variable "rg_name"{
    description = "resource-gp-name"
    type        = string
    default     = "rg"
}
variable "location"{
    description = "resource-location"
    type        = string
    default     = "uksouth"
}
#Window Virtual Machine variables
variable "win_vm_name"{
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
