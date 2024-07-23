# Create Log group for each Microservice
resource "aws_cloudwatch_log_group" "ecs-log-group" {
  for_each = var.microservices
  name = "${each.key}-LogGroup"
  retention_in_days = 7
}
