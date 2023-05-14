# This file is used to create the Auto Scaling Group for the ECS Cluster
resource "aws_appautoscaling_target" "ecs-target" {
    max_capacity        = 3
    min_capacity        = 1
    resource_id         = aws_ecs_service.microservices[each.key].id
    scalable_dimension  = "ecs:service:DesiredCount"
    service_namespace   = "ecs"
}

# Auto Scale Based on the Memory Usage
resource "aws_appautoscaling_policy" "ecs-policy-memory" {
    name               = "memory-autoscaling"
    policy_type        = "TargetTrackingScaling"
    resource_id        = aws_appautoscaling_target.ecs-target.resource_id
    scalable_dimension = aws_appautoscaling_target.ecs-target.scalable_dimension
    service_namespace  = aws_appautoscaling_target.ecs-target.service_namespace

    target_tracking_scaling_policy_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ECSServiceAverageMemoryUtilization"
        }
        target_value = 80
    } 
}

# Auto scale Based on the CPU Usage
resource "aws_appautoscaling_policy" "ecs-policy-cpu" {
    name               = "cpu-autoscaling"
    policy_type        = "TargetTrackingScaling"
    resource_id        = aws_appautoscaling_target.ecs-target.resource_id
    scalable_dimension = aws_appautoscaling_target.ecs-target.scalable_dimension
    service_namespace  = aws_appautoscaling_target.ecs-target.service_namespace

    target_tracking_scaling_policy_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
        }
        target_value = 60
    }  
}