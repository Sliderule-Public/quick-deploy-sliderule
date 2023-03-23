resource "aws_lb_target_group" "web" {
  name                 = "${local.stack_name}-web"
  port                 = 8000
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 10
  health_check {
    enabled             = true
    matcher             = "200-304,401"
    protocol            = "HTTP"
    path                = "/"
    timeout             = 30
    interval            = 61
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {}
}

resource "aws_lb_listener_rule" "web" {
  listener_arn = module.shared_eks_load_balancer.listener_arn
  tags         = {}

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }

  condition {
    host_header {
      values = ["${local.stack_name}.${var.root_domain}"]
    }
  }
}