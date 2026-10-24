vpc_cidr_block = "10.0.0.0/16"

region = "ap-southeast-1"

AZ = [
  "ap-southeast-1a",
  "ap-southeast-1b"
]

public_subnet = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_app = [
  "10.0.16.0/20",
  "10.0.48.0/20"
]

private_subnet_db = [
  "10.0.32.0/24",
  "10.0.33.0/24"
]