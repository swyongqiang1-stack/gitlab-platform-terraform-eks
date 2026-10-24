terraform {
  backend "s3" {
    bucket       = "elden-state-bucket"
    key          = "gitlab-storage/terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
  }
}



locals {
  buckets = toset([
    "artifacts",
    "lfs",
    "uploads",
    "packages",
    "backups",
    "backup-tmp"
  ])
}

resource "aws_s3_bucket" "gitlab" {
  for_each      = local.buckets
  bucket        = "463884819678-${each.key}"
  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Component = "storage"
  }
}

resource "aws_s3_bucket_public_access_block" "gitlab" {
  for_each = aws_s3_bucket.gitlab

  bucket = each.value.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "gitlab" {
  for_each = aws_s3_bucket.gitlab

  bucket = each.value.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gitlab" {
  for_each = aws_s3_bucket.gitlab

  bucket = each.value.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "gitlab" {
  for_each = aws_s3_bucket.gitlab

  bucket = each.value.id

  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
  depends_on = [
  aws_s3_bucket_versioning.gitlab
]
}







resource "aws_s3_bucket" "loki" {
  bucket        = "463884819678-loki"
  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Component = "storage"
  }
}

resource "aws_s3_bucket_public_access_block" "loki" {
  bucket = aws_s3_bucket.loki.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "loki" {
  bucket = aws_s3_bucket.loki.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "loki" {
  bucket = aws_s3_bucket.loki.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "loki" {
  bucket = aws_s3_bucket.loki.id

  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    filter {}

  }
}



