terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.3.0"
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



provider "helm" {
  kubernetes = {
    host = aws_eks_cluster.gitlab.endpoint

    cluster_ca_certificate = base64decode(
      aws_eks_cluster.gitlab.certificate_authority[0].data
    )

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        aws_eks_cluster.gitlab.name
      ]
      command = "aws"
    }
  }
}

provider "kubernetes" {
  host = aws_eks_cluster.gitlab.endpoint

  cluster_ca_certificate = base64decode(
    aws_eks_cluster.gitlab.certificate_authority[0].data
  )

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      aws_eks_cluster.gitlab.name
    ]
    command = "aws"
  }
}


module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block     = var.vpc_cidr_block
  region             = var.region
  AZ                 = var.AZ
  public_subnet      = var.public_subnet
  private_subnet_app = var.private_subnet_app
  private_subnet_db  = var.private_subnet_db
}

