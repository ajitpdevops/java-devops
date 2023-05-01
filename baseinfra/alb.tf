# Create the ALB
resource "aws_lb" "main-alb" {
    name               = "application-load-balancer"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb-sg.id]
    subnets            = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id]
    enable_deletion_protection = false
    
    tags = {
        Name = "${var.environment}-ALB"
    }
}