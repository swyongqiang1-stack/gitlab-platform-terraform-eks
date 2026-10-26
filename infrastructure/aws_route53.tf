resource "aws_route53_zone" "main" {
  name          = "erben.cn"
  force_destroy = false

  tags = {
    Component = "dns"
  }
}

