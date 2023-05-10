terraform {
    required_version = "~> 1.4.5"
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.64.0"
        }
    }
    backend "s3" {
      
    }
}

provider "aws" {
    region = var.aws_region
    # access_key = var.aws_access_key
    # secret_key = var.aws_secret_key
}
