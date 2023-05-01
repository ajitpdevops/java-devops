
# Create a security group for ALB

resource "aws_security_group" "alb-sg" {
  name        = "ALB Security Group"
  description = "Allow HTTP Traffic to ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Allow all inbound traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    IPv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    IPv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.environment}-ALB-SG"
  }
}

# Create a security group for ECS to allow 8080 8081 & 3000 ports

resource "aws_security_group" "ecs-sg" {
  name        = "ECS Security Group"
  description = "Allow Traffic to ECS Cluster"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow inbound traffic for first app"
    from_port       = var.spring_1_port
    to_port         = var.spring_1_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }
  ingress {
    description     = "Allow all inbound traffic for second app"
    from_port       = var.spring_2_port
    to_port         = var.spring_2_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }
  ingress {
    description     = "Allow all inbound traffic frontend app"
    from_port       = var.frontend_port
    to_port         = var.frontend_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    IPv6_cidr_blocks = ["::/0"]
  }
}

# Create a security group for postgres

resource "aws_security_group" "rds-sg" {
  name        = "RDS Security Group"
  description = "Allow Traffic to RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow inbound traffic"
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs-sg.id]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    IPv6_cidr_blocks = ["::/0"]
  }
}
