variable "vpc_cidr_block" {
  type = string
}

variable "region" {
  type = string
}

variable "AZ" {
  type = list(string)
}

variable "public_subnet" {
  type = list(string)
}

variable "private_subnet_app" {
  type = list(string)
}

variable "private_subnet_db" {
  type = list(string)
}