# Create a new ECR Reposiroty for the application

resource "aws_ecr_repository" "ecr-repo" {
    name                    = "${var.ecr_repo_name}"
    image_tag_mutability    = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
    tags = {
        Name = "springboot-app"
    }
}