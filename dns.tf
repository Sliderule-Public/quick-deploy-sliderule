module "route53_dns_api" {
  count          = var.use_route53 == true ? 1 : 0
  source         = "./modules/route53_record"
  name           = "api-${local.stack_name}"
  root_domain    = var.root_domain
  target         = module.shared_eks_load_balancer.dns_name
  target_zone_id = module.shared_eks_load_balancer.lb_hosted_zone
  zone_id        = data.aws_route53_zone.main.zone_id
}

module "route53_dns_web" {
  count          = var.use_route53 == true ? 1 : 0
  source         = "./modules/route53_record"
  name           = local.stack_name
  root_domain    = var.root_domain
  target         = module.shared_eks_load_balancer.dns_name
  target_zone_id = module.shared_eks_load_balancer.lb_hosted_zone
  zone_id        = data.aws_route53_zone.main.zone_id
}