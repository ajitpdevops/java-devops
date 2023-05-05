resource "aws_lb_target_group" "ecs-app-target-group-1" {
  name        = "${var.service_name}-APP1-TG"
  port        = var.container_port_1
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.baseinfra.outputs.vpc_id
  target_type = "ip"

  health_check {
    path                = "${var.app1_health_check_path}"
    port                = var.container_port_1
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 60
    timeout             = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.service_name}-APP1-TG"
  }
}

resource "aws_lb_target_group" "ecs-app-target-group-2" {
  name        = "${var.service_name}-APP2-TG"
  port        = var.container_port_2
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.baseinfra.outputs.vpc_id
  target_type = "ip"

  health_check {
    path                = "${var.app2_health_check_path}"
    port                = var.container_port_2
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 60
    timeout             = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.service_name}-APP2-TG"
  }
}

resource "aws_lb_listener_rule" "ecs-app-listener-rule-1" {
  listener_arn = data.terraform_remote_state.baseinfra.outputs.ecs_alb_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-app-target-group-1.arn
  }

  condition {
    path_pattern {
      values = ["/app*"]
    }
  }
}

resource "aws_lb_listener_rule" "ecs-app-listener-rule-2" {
  listener_arn = data.terraform_remote_state.baseinfra.outputs.ecs_alb_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-app-target-group-1.arn
  }

  condition {
    path_pattern {
      values = ["/web*"]
    }
  }
}

