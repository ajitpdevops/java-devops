resource "aws_security_group" "app-security-group" {
    name        = "ECS-Security-Group"
    description = "Security group for the application"
    vpc_id      = "${data.terraform_remote_state.baseinfra.outputs.vpc_id}"
    ingress {
        from_port   = var.container_port_1
        to_port     = var.container_port_1
        protocol    = "tcp"
        cidr_blocks = ["${data.terraform_remote_state.baseinfra.outputs.vpc_cidr_block}"]
    }

    ingress {
        from_port   = var.container_port_2
        to_port     = var.container_port_2
        protocol    = "tcp"
        cidr_blocks = ["${data.terraform_remote_state.baseinfra.outputs.vpc_cidr_block}"]
    }

    ingress {
        from_port   = var.frontend_container_port
        to_port     = var.frontend_container_port
        protocol    = "tcp"
        cidr_blocks = ["${data.terraform_remote_state.baseinfra.outputs.vpc_cidr_block}"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }

    tags = {
        Name = "${var.service_name}-SG"
    }
  
}