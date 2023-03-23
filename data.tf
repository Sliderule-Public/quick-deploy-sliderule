data "aws_eks_cluster" "main" {
  name = var.eks_cluster_name
}

data "aws_eks_cluster_auth" "main" {
  name = var.eks_cluster_name
}

data "aws_route53_zone" "main" {
  name = var.root_domain
}

data "aws_caller_identity" "current" {}