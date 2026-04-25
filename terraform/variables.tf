variable "location" {
  default = "Canada Central"
}

variable "resource_group_name" {
  default = "zero-trust-rg"
}

variable "db_password" {
  sensitive = true
  default = "password@1"
}