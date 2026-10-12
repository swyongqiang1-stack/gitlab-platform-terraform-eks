resource "aws_s3_bucket" "gitlab" {
  bucket        = "elden-state-bucket"
  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Component = "storage"
  }
}



resource "aws_s3_bucket_versioning" "state" {
  bucket = "elden-state-bucket"

  versioning_configuration {
    status = "Enabled"
  }
}