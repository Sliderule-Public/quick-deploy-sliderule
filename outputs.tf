output "api_endpoint" {
  value = "api-${local.stack_name}.${var.root_domain}"
}

output "app_endpoint" {
  value = "${local.stack_name}.${var.root_domain}"
}