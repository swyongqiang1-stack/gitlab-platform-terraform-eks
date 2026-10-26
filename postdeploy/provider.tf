terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
  }
}

provider "aws" {
  region = local.AZ.region
  default_tags {
    tags = {
      Project     = "gitlab"
      Environment = "prod"
      ManagedBy   = "terraform"
    }
  }
}

