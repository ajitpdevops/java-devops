# Create a new ECR Reposiroty for the application
resource "aws_ecr_repository" "ecr-repo-1" {
    name                    = "${var.microservices_1}"
    image_tag_mutability    = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
    tags = {
        Name = "${var.microservices_1}-app"
    }
}

resource "aws_ecr_repository" "ecr-repo-2" {
    name                    = "${var.microservices_2}"
    image_tag_mutability    = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
    tags = {
        Name = "${var.microservices_2}-app"
    }
}

resource "aws_ecr_repository" "ecr-repo-3" {
    name                    = "${var.microservices_3}"
    image_tag_mutability    = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
    tags = {
        Name = "${var.microservices_3}-app"
    }
}
