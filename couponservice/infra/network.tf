data "aws_availability_zones" "available" {
  
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "172.17.0.0/16"
}

# Subnets [ private and public ]

# private subnet
resource "aws_subnet" "private" {
  count = var.az_count
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.main.id
}

# public subnet
resource "aws_subnet" "public" {
  count = var.az_count
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.main.id
}

# Internet Gateway for the public subnets 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Route the public subnet traffic  through the IGW 
resource "aws_route" "internet_rt" {
  route_table_id = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

# NAT Gateway [ 2 EIP] for internet, place them in public subnet 
# Create a new route table for the private subnets, it routes non-local trafic to internet via NAT Gateway
# Associate the route with private subnet