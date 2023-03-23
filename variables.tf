variable "vpc_id" {
  type = string
}
variable "public_subnet_ids" {
  type = list(string)
}
variable "root_domain" {
  type = string
}
variable "region" {
  type        = string
  description = "aws region to deploy into"
}

variable "eks_cluster_name" {
  type = string
}
variable "use_route53" {
  type    = bool
  default = false
}
variable "sliderule_namespace" {
  type    = string
  default = "sliderule"
}
variable "use_cloudflare" {
  type    = bool
  default = false
}
variable "deploy_aws_eks_load_balancer_controller" {
  type    = bool
  default = false
}
variable "create_oidc_provider" {
  type    = bool
  default = false
}
variable "validate_acm_certificate" {
  type    = bool
  default = true
}
variable "elb_idle_timeout" {
  type    = number
  default = 60
}
variable "environment" {
  type    = string
  default = "demo"
}
variable "company_name" {
  type    = string
  default = "sliderule"
}
variable "cloudflare_token" {
  type    = string
  default = ""
}