resource "aws_acm_certificate" "main" {
  domain_name       = "*.${var.root_domain}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "main" {
  name = var.root_domain
}

resource "aws_route53_record" "validation" {
  for_each = {
  for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
    name   = dvo.resource_record_name
    record = dvo.resource_record_value
    type   = dvo.resource_record_type
  }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

resource "null_resource" "previous" {}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous, aws_acm_certificate.main]

  create_duration = "30s"
}

resource "aws_acm_certificate_validation" "main" {
  depends_on              = [time_sleep.wait_30_seconds]
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.name]
}