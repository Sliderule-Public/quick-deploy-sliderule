resource "helm_release" "sliderule" {
  depends_on       = [aws_lb_target_group.web, aws_lb_target_group.api, module.eks_load_balancer_security_group]
  name             = local.stack_name
  repository       = "https://sliderule-public.github.io/helm-charts"
  chart            = "sliderule_demo"
  version          = "0.1.7"
  namespace        = local.stack_name
  create_namespace = true

  set {
    name  = "api_tg_arn"
    value = aws_lb_target_group.api.arn
  }

  set {
    name  = "web_tg_arn"
    value = aws_lb_target_group.web.arn
  }

  set {
    name  = "alb_sg_id"
    value = module.eks_load_balancer_security_group.security_group_id
  }
}
