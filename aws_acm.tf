resource "aws_acm_certificate" "gitlab" {
  domain_name               = "*.erben.cn"
  subject_alternative_names = ["erben.cn"]
  validation_method         = "DNS"

  tags = {
    Component = "certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}