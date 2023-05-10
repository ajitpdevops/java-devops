resource "aws_lb_target_group" "microservices" {
  for_each = var.microservices

  name_prefix     = each.key
  port            = each.value.container_port
  protocol        = "HTTP"
  vpc_id          = data.terraform_remote_state.baseinfra.outputs.vpc_id
  target_type     = "ip" 

  health_check {
    path                = each.value.health_check_path
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = each.key
    Environment = var.environment
  }
}

resource "aws_lb_listener" "microservices" {
  for_each = var.microservices

  listener_arn = data.terraform_remote_state.baseinfra.outputs.ecs_alb_listener_arn
  priority     = 100 + each.value.container_port

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.microservices[each.key].arn
  }

  condition {
    field  = "path-pattern"
    values = ["/${each.value.health_check_path}/*"]
  }

}
