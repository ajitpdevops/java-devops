# This file is used to create the Auto Scaling Group for the ECS Cluster
# resource "aws_appautoscaling_target" "ecs-target" {
#     for_each            = var.microservices
#     max_capacity        = 3
#     min_capacity        = 1
#     resource_id         = aws_ecs_service.microservices[each.key].id
#     scalable_dimension  = "ecs:service:DesiredCount"
#     service_namespace   = "ecs"
# }

resource "aws_appautoscaling_target" "ecs-target" {
  for_each           = var.microservices 
  max_capacity       = 4
  min_capacity       = 1
#   resource_id        = "service/${aws_ecs_cluster.example.name}/${aws_ecs_service.example.name}"
  resource_id        = "service/${data.terraform_remote_state.baseinfra.outputs.ecs_cluster_name}/${aws_ecs_service.microservices[each.key].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

# Auto Scale Based on the Memory Usage
resource "aws_appautoscaling_policy" "ecs-policy-memory" {
    for_each           = var.microservices 
    name               = "memory-autoscaling"
    policy_type        = "TargetTrackingScaling"
    resource_id        = aws_appautoscaling_target.ecs-target[each.key].resource_id
    scalable_dimension = aws_appautoscaling_target.ecs-target[each.key].scalable_dimension
    service_namespace  = aws_appautoscaling_target.ecs-target[each.key].service_namespace

    target_tracking_scaling_policy_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ECSServiceAverageMemoryUtilization"
        }
        target_value = 80
    } 
}

# Auto scale Based on the CPU Usage
# resource "aws_appautoscaling_policy" "ecs-policy-cpu" {
#     for_each           = var.microservices
#     name               = "cpu-autoscaling"
#     policy_type        = "TargetTrackingScaling"
#     resource_id        = aws_appautoscaling_target.ecs-target[each.key].resource_id
#     scalable_dimension = aws_appautoscaling_target.ecs-target[each.key].scalable_dimension
#     service_namespace  = aws_appautoscaling_target.ecs-target[each.key].service_namespace

#     target_tracking_scaling_policy_configuration {
#         predefined_metric_specification {
#             predefined_metric_type = "ECSServiceAverageCPUUtilization"
#         }
#         target_value = 60
#     }  
# }