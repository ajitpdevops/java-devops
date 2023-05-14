# Create ECR repository for each microservice
resource "aws_ecr_repository" "microservices" {
    for_each = var.microservices
    
    name = each.key
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
    tags = {
        Name = "${each.key}-app"
    }
}
