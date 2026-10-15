resource "aws_kms_key" "gitlab" {
  description             = "GitLab secrets encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  tags = {
    Component = "security"
  }
}
