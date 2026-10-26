terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      Project     = "gitlab"
      Environment = "prod"
      ManagedBy   = "terraform"
    }
  }
}


resource "aws_s3_bucket" "gitlab" {
  bucket        = "elden-state-bucket-gitlab"
  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Component = "storage"
  }
}



resource "aws_s3_bucket_versioning" "state" {
  bucket = "elden-state-bucket-gitlab"

  versioning_configuration {
    status = "Enabled"
  }
}