resource "aws_ecs_task_definition" "microservices" {
  for_each = var.microservices

  family                   = each.key
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = each.value.per_container_cpu
  memory                   = each.value.per_container_memory
  task_role_arn            = data.terraform_remote_state.baseinfra.outputs.ecs_cluster_role_arn
  execution_role_arn       = data.terraform_remote_state.baseinfra.outputs.ecs_task_execution_role_arn
  container_definitions = jsonencode([
    {
      "name" : "${each.key}",
      "image" : format("%s:%s", data.terraform_remote_state.baseinfra.outputs.ecr_repositories[each.key], each.value.image_tag),
      "essential" : true,
      "environment" : [
        {
          "name" : "SPRING_PROFILES_ACTIVE",
          "value" : "${each.value.spring_profiles}"
        },
        {
          "name" : "SPRING_DATASOURCE_URL",
          "value" : "jdbc:postgres://${data.terraform_remote_state.baseinfra.outputs.rds_endpoint}/${each.value.database_name}"
        },
        {
          "name" : "SPRING_DATASOURCE_USERNAME",
          "value" : local.db_creds["username"]
        },
        {
          "name" : "SPRING_PORT",
          # "value" : "${each.value.container_port}"
          "value" : format("%v", each.value.container_port)
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


# Create ECS Servuce for each microservice
resource "aws_ecs_service" "microservices" {
  for_each = var.microservices

  name            = each.key
  task_definition = aws_ecs_task_definition.microservices[each.key].arn
  desired_count   = each.value.desired_task_count
  cluster         = data.terraform_remote_state.baseinfra.outputs.ecs_cluster_id
  launch_type     = var.launch_type

  network_configuration {
    subnets          = flatten([data.terraform_remote_state.baseinfra.outputs.public_subnets])
    security_groups  = [data.terraform_remote_state.baseinfra.outputs.ecs-sg-id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.microservices[each.key].arn
    container_name   = each.key
    container_port   = each.value.container_port
  }
}

