resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-ecs-cluster"
}

resource "aws_alb" "ecs-cluster-alb" {
  name            = "${var.environment}-ecs-cluster-alb"
  internal        = false
  security_groups = [aws_security_group.alb-sg.id]
  subnets         = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id]

  tags = {
    Name = "${var.ecs_cluster_name}-ALB"
  }
}
