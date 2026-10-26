terraform {
  backend "s3" {
    bucket       = "elden-state-bucket"
    key          = "gitlab/prod/terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
  }
}

