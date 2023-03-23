module "acm_certificate_route53" {
  count       = var.use_route53 == true ? 1 : 0
  source      = "./modules/acm_certificate_route53"
  root_domain = var.root_domain
}

#module "acm_certificate_cloudflare" {
#  count            = var.use_cloudflare == true ? 1 : 0
#  source           = "./modules/acm_certificate_cloudflare"
#  root_domain      = var.root_domain
#  cloudflare_token = ""
#}