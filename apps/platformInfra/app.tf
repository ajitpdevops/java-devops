resource "aws_ecs_task_definition" "microservices" {
  for_each = var.microservices

  family                   = each.key
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = each.value.per_container_cpu
  memory                   = each.value.per_container_memory
  task_role_arn            = aws_iam_role.fargate-iam-role.arn
  execution_role_arn       = aws_iam_role.fargate-iam-role.arn # should be execution role 
  container_definitions = jsonencode([
    {
      "name" : each.key,
      "image" : each.value.image_url,
      "essential" : true,
      "environment" : [
        {
          "name" : "SPRING_PROFILES_ACTIVE",
          "value" : each.value.spring_profiles
        }
      ],
      "portMappings" : [
        {
          "containerPort" : each.value.container_port,
          "hostPort" : each.value.container_port,
          "protocol" : "tcp"
        }
      ],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : "${each.key}-LogGroup",
          "awslogs-region" : var.aws_region,
          "awslogs-stream-prefix" : "${each.key}-LogStream"
        }
      },
    }
  ])
}




resource "aws_ecs_service" "springboot-ecs-service" {
  name            = var.service_name
  task_definition = aws_ecs_task_definition.springboot-task-definition.arn
  desired_count   = var.desired_task_count
  cluster         = data.terraform_remote_state.baseinfra.outputs.ecs_cluster_id
  launch_type     = var.launch_type

  network_configuration {
    subnets          = flatten([data.terraform_remote_state.baseinfra.outputs.public_subnets])
    security_groups  = [aws_security_group.app-security-group.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-app-target-group-1.arn
    container_name   = var.ecs_service_name_1
    container_port   = var.container_port_1
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-app-target-group-2.arn
    container_name   = var.ecs_service_name_2
    container_port   = var.container_port_2
  }
}
