module "eks_load_balancer_security_group" {
  source              = "git@github.com:Modern-Logic/terraform-modules.git//simple/vpc_security_group"
  environment         = var.environment
  company_name        = var.company_name
  tags                = {}
  security_group_name = "eks-alb"
  vpc_id              = var.vpc_id
  ingress_rules       = [
    {
      description = "Allow 443 from Internet"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      description = "Allow 443 from Internet"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    }
  ]


  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]
}

module "shared_eks_load_balancer" {
  source             = "git@github.com:Modern-Logic/terraform-modules.git//simple/load_balancer"
  environment        = var.environment
  company_name       = var.company_name
  tags               = {}
  load_balancer_name = "eks-quickdemo"
  cert_arn           = var.use_route53 == true ? module.acm_certificate_route53[0].cert_arn : ""
  idle_timeout       = var.elb_idle_timeout
  subnets            = var.public_subnet_ids
  vpc_id             = var.vpc_id
  security_group_id  = module.eks_load_balancer_security_group.security_group_id
  enable_access_logs = false
}