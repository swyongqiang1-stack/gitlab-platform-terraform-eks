terraform {
  backend "s3" {
    bucket       = "elden-state-bucket"
    key          = "platform/terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
  }
}