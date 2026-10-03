terraform {
  backend "s3" {
    bucket       = local.s3.bucket
    key          = local.s3.key
    region       = local.region
    use_lockfile = true
  }
}

