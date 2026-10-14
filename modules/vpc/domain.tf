resource "aws_route53domains_domain" "main" {
  provider = aws.domains

  domain_name       = var.domain_name
  duration_in_years = 1

  auto_renew    = true
  transfer_lock = true

  registrant_privacy = true
  admin_privacy      = true
  tech_privacy       = true

  # 域名注册人
  registrant_contact {
    contact_type   = "PERSON"
    first_name     = var.first_name
    last_name      = var.last_name
    email          = "gohu@live.cn"
    phone_number   = var.phone_number
    country_code   = var.country_code
    city           = var.city
    state          = var.state
    address_line_1 = var.address
    zip_code       = var.zip_code
  }

  # 域名管理员
  admin_contact {
    contact_type   = "PERSON"
    first_name     = var.first_name
    last_name      = var.last_name
    email          = "gohu@live.cn"
    phone_number   = var.phone_number
    country_code   = var.country_code
    city           = var.city
    state          = var.state
    address_line_1 = var.address
    zip_code       = var.zip_code
  }

  # 技术联系人
  tech_contact {
    contact_type   = "PERSON"
    first_name     = var.first_name
    last_name      = var.last_name
    email          = "gohu@live.cn"
    phone_number   = var.phone_number
    country_code   = var.country_code
    city           = var.city
    state          = var.state
    address_line_1 = var.address
    zip_code       = var.zip_code
  }

  tags = {
    Project   = "gitlab"
    ManagedBy = "terraform"
    Component = "domain"
  }

  lifecycle {
    prevent_destroy = true
  }
}