data "aws_route53_zone" "main" {
  name = var.root_domain
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.name
  type    = var.type
  alias {
    name                   = var.target
    zone_id                = var.target_zone_id
    evaluate_target_health = false
  }
}