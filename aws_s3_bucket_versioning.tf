resource "aws_s3_bucket_versioning" "state" {
  bucket = local.s3.bucket

  versioning_configuration {
    status = "Enabled"
  }
}