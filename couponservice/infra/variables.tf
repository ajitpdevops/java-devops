variable "aws_region" {
  description = "The AWS Region"
  default = "us-east-2"
}

variable "az_count" {
  description = "Number of AZs to expand"
  default = 2
}