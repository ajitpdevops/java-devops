resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-ecs-cluster"
}

