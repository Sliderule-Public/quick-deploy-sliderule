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

resource "cloudflare_record" "api" {
  zone_id         = data.cloudflare_zone.main.id
  allow_overwrite = true
  proxied         = false
  name            = "${var.api_subdomain}.${var.root_domain}"
  type            = "CNAME"
  value           = var.alb_endpoint
  ttl             = 60
}