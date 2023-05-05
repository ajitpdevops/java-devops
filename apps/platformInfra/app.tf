data "template_file" "ecs-task-definition-template" {
    template = file("task_definition.json")
    
    vars = {
        # SpringBoot Application 1 Variables for tasks
        spring_boot_container_1     = "${var.ecs_service_name_1}"
        spring_profiles_1           = "${var.spring_profiles_1}"
        ecs_service_name_1          = "${var.ecs_service_name_1}"
        docker_image_url_1          = "${var.docker_image_url_1}"
        memory_reservation_1        = "${var.memory_reservation_1}"
        cpu_1                       = "${var.cpu_1}"
        container_port_1            = "${var.container_port_1}"
        
        # SpringBoot Application 2 Variables for tasks
        spring_boot_container_2     = "${var.ecs_service_name_2}"
        spring_profiles_2           = "${var.spring_profiles_2}"
        ecs_service_name_2          = "${var.ecs_service_name_2}"
        docker_image_url_2          = "${var.docker_image_url_2}"
        container_port_2            = "${var.container_port_2}"
        memory_reservation_2        = "${var.memory_reservation_2}"
        cpu_2                       = "${var.cpu_2}"
        
        # Frontend Variables for tasks
        frontend_container          = "${var.frontend_container_name}"
        frontend_image_url          = "${var.frontend_image_url}"
        frontend_container_port     = "${var.frontend_container_port}"
        memory_reservation_3        = "${var.memory_reservation_3}"
        cpu_3                       = "${var.cpu_3}"

        region                      = "${var.aws_region}"

    }
}

resource "aws_ecs_task_definition" "springboot-task-definition" {
    container_definitions       = data.template_file.ecs-task-definition-template.rendered
    family                      = "${var.ecs_task_definition_family}"
    cpu                         = "${var.cpu}"
    memory                      = "${var.memory}"
    requires_compatibilities    = ["${var.requires_compatibility}"]
    network_mode                = "awsvpc"
    execution_role_arn          = aws_iam_role.fargate-iam-role.arn
    task_role_arn               = aws_iam_role.fargate-iam-role.arn
  
}

resource "aws_ecs_service" "springboot-ecs-service" {
    name                        = "${var.service_name}"
    task_definition             = "${aws_ecs_task_definition.springboot-task-definition.arn}"
    desired_count               = "${var.desired_task_count}"
    cluster                     = "${data.terraform_remote_state.baseinfra.outputs.ecs_cluster_id}"
    launch_type                 = "${var.launch_type}"

    network_configuration {
        subnets                 = flatten([data.terraform_remote_state.baseinfra.outputs.public_subnets])
        security_groups         = [aws_security_group.app-security-group.id]
        assign_public_ip        = true
    }

    load_balancer {
        target_group_arn        = aws_lb_target_group.ecs-app-target-group-1.arn
        container_name          = var.ecs_service_name_1
        container_port          = var.container_port_1
    }

    load_balancer {
        target_group_arn        = aws_lb_target_group.ecs-app-target-group-2.arn
        container_name          = var.ecs_service_name_2
        container_port          = var.container_port_2
    }

}