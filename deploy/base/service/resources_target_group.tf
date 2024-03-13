resource "aws_alb_target_group" "nest_api" {
  name        = var.service_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 60
    timeout             = 15
    healthy_threshold   = 2
    unhealthy_threshold = 10
    matcher             = "200"
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_alb_listener_rule" "nest_api" {
  listener_arn = var.alb_listener_arn

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_alb_target_group.nest_api]

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.nest_api.id
  }

  condition {
    host_header {
      values = ["api.${var.service_master_stage_domain}"]
    }
  }
}
