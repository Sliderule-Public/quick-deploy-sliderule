terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.3.0"
}

data "cloudflare_zone" "main" {
  name = var.root_domain
}


resource "aws_acm_certificate" "main" {
  domain_name       = "*.${var.root_domain}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "cf_record" {
  for_each = {
  for item in aws_acm_certificate.main.domain_validation_options : item.domain_name => {
    name   = item.resource_record_name
    record = item.resource_record_value
    type   = item.resource_record_type
  }
  }

  zone_id         = data.cloudflare_zone.main.id
  allow_overwrite = false
  proxied         = false
  name            = each.value.name
  type            = each.value.type
  value           = each.value.record
  ttl             = 1
}

resource "null_resource" "previous" {}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous, aws_acm_certificate.main]

  create_duration = "300s"
}

resource "aws_acm_certificate_validation" "main" {
  depends_on              = [time_sleep.wait_30_seconds]
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in cloudflare_record.cf_record : record.hostname]
}