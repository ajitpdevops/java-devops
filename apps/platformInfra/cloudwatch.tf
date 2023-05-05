resource "aws_cloudwatch_log_group" "ecs-log-group-1" {
  name = "${var.ecs_service_name_1}-LogGroup"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "ecs-log-group-2" {
  name = "${var.ecs_service_name_2}-LogGroup"
  retention_in_days = 7
}
