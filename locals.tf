locals {
  s3 ={
    bucket = "elden-state-bucket"
    key = "gitlab/prod/terraform.tfstate"
  }
}



locals {
  AZ = {
    region = "ap-southeast-1"
    AZ-A = "ap-southeast-1a"
    AZ-B = "ap-southeast-1b"
  }
}