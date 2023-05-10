# Create the ALB
resource "aws_lb" "main-alb" {
  name                       = "${var.environment}-ALB"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-sg.id]
  subnets                    = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id]
  enable_deletion_protection = false

  tags = {
    Name = "${var.environment}-ALB"
  }
}

resource "aws_lb_target_group" "ecs-default-target-group" {
  name     = "${var.environment}-ecs-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
  }

  tags = {
    Name = "${var.environment}-ALB-TG"
  }
}

resource "aws_lb_listener" "ecs-alb-http-listener" {
  load_balancer_arn = aws_lb.main-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}

resource "aws_lb_listener" "ecs-alb-https-listener" {
  load_balancer_arn = aws_lb.main-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.lb_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-default-target-group.arn
  }

  depends_on = [aws_lb_target_group.ecs-default-target-group]
}
