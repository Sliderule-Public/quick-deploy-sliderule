variable "vpc_id" {
  type        = string
  description = "vpc id to deploy into"
}
variable "public_subnet_ids" {
  type        = list(string)
  description = "public subnet ids to deploy into"
}
variable "root_domain" {
  type        = string
  description = "root domain to deploy into"
}
variable "region" {
  type        = string
  description = "aws region to deploy into"
}

variable "eks_cluster_name" {
  type        = string
  description = "eks cluster name"
}
variable "use_route53" {
  type        = bool
  default     = false
  description = "Whether to use route53 for dns"
}
variable "sliderule_namespace" {
  type        = string
  default     = "sliderule"
  description = "Kubernetes namespace to deploy sliderule into"
}
variable "deploy_aws_eks_load_balancer_controller" {
  type        = bool
  default     = false
  description = "Whether to deploy the AWS EKS Load Balancer Controller"
}
variable "create_oidc_provider" {
  type        = bool
  default     = false
  description = "Whether to create an OIDC provider for the cluster"
}
variable "validate_acm_certificate" {
  type        = bool
  default     = true
  description = "Whether to validate the ACM certificate"
}
variable "elb_idle_timeout" {
  type        = number
  default     = 60
  description = "The ELB idle timeout value, in seconds. The range is 1-4000 seconds. The default value is 60 seconds."
}
variable "environment" {
  type        = string
  default     = "demo"
  description = "The environment to deploy into"
}
variable "company_name" {
  type        = string
  default     = "sliderule"
  description = "The company name to use"
}
variable "cloudflare_token" {
  type        = string
  default     = ""
  description = "Token to use for Cloudflare provider. Currently not a fully-supported feature, leave this blank for now."
}