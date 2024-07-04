locals {
  owner       = var.owner
  environment = var.environment
  tags = {
    environment = "secure"
    project     = "solar"
  }
}