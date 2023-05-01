output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_1a_id" {
  value = aws_subnet.public-subnet-1a.id
}

output "public_subnet_1b_id" {
  value = aws_subnet.public-subnet-1b.id
}

output "private_subnet_1a_id" {
  value = aws_subnet.private-subnet-1a.id
}

output "private_subnet_1b_id" {
  value = aws_subnet.private-subnet-1b.id
}