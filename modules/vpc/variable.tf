variable "vpc_cidr_block" {
  type = string
}

variable "email" {
  type = string
}

variable "public_subnet" {
  type = list(string)
}

variable "private_subnet_db" {
  type = list(string)
}

variable "private_subnet_app" {
  type = list(string)
}

variable "AZ" {
  type = list(string)
}

variable "region" {
  type = string
}