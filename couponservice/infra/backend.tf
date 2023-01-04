terraform {
  backend "s3" {
    bucket = "cwa-devops-terraform-backend"
    key = "couponservice.tfstate"
    region = "us-est-2"
    profile = "cwa-admin"
  }
}