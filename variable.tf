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
    description = "resourcegp-name"
    type        = "string"
    default     = "rg"
}
variable "location"{
    description = "resource-location"
    type        = "string"
    default     = "uksouth"
}
#Window Virtual Machine variables
variable "win_vm_name"{
    description = "winvm-name"
    type        = "string"
    default     = "winvm"  
}
variable "win_vm_username" {
  description = "winvm-username"
  type        = string
  default     = "adminuser"
}
variable "win_vm_password" {
  description = "winvm-password"
  type        = string
  default     = "P@$$w0rd1234!"
}
#Network security group for database 
variable "db_nsg" {
    description = "nsg-db-name"
    type        = string
    default     = "newtorksecgpdb"
}
variable "nsg_db_subnet" {
  description = "nsg-db-subnetnmae"
  type        = string
  default     = "subnet"
}
variable "db_nsrule" {
  description = "db-networksecrule-name"
  type        = string
  default     = "networksecrule"
}
