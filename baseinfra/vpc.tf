# VPC Creation
resource "aws_vpc" "main" {
    cidr_block              = "${var.vpc_cidr_block}"
    enable_dns_hostnames    = true
    tags = {
        Name                = "${var.environment}-vpc"
    }
}

# Public Subnet Creation
resource "aws_subnet" "public-subnet-1a" {
    vpc_id              = aws_vpc.main.id
    cidr_block          = var.public_subnet_1a_cidr_block
    availability_zone   = "us-east-1a"
    

    tags = {
        Name            = "${var.environment}-public-subnet-1a"
    }
}

resource "aws_subnet" "public-subnet-1b" {
    vpc_id              = aws_vpc.main.id
    cidr_block          = var.public_subnet_1b_cidr_block
    availability_zone   = "us-east-1b"
    tags = {
        Name            = "${var.environment}-public-subnet-1b"
    }
}

# Private Subnet Creation
resource "aws_subnet" "private-subnet-1a" {
    vpc_id              = aws_vpc.main.id
    cidr_block          = var.private_subnet_1a_cidr_block
    availability_zone   = "us-east-1a"
    tags = {
        Name            = "${var.environment}-private-subnet-1a"
    }
}

resource "aws_subnet" "private-subnet-1b" {
    vpc_id              = aws_vpc.main.id
    cidr_block          = var.private_subnet_1b_cidr_block
    availability_zone   = "us-east-1b"

    tags = {
        Name            = "${var.environment}-private-subnet-1b"
    }
  
}

# Route Table Creation - Public 
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "${var.environment}-public-route-table"
    }
}

# Route Table Creation - Private
resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "${var.environment}-private-route-table"
    }
}

# Route Table Association - Public

resource "aws_route_table_association" "public-subnet-1a" {
    subnet_id       = aws_subnet.public-subnet-1a.id
    route_table_id  = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-1b" {
    subnet_id       = aws_subnet.public-subnet-1b.id
    route_table_id  = aws_route_table.public-route-table.id
}

# Route Table Association - Private

resource "aws_route_table_association" "private-subnet-1a" {
    subnet_id       = aws_subnet.private-subnet-1a.id
    route_table_id  = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-subnet-1b" {
    subnet_id       = aws_subnet.private-subnet-1b.id
    route_table_id  = aws_route_table.private-route-table.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "elastic-ip-for-nat-gateway" {
    vpc                         = true
    associate_with_private_ip   = var.private_ip_for_nat_gateway

    tags = {
      Name = "${var.environment}-EIP-for-NAT-Gateway"
    }
}

# Nat Gateway creation
resource "aws_nat_gateway" "nat-gw" {
    allocation_id   = aws_eip.elastic-ip-for-nat-gateway.id
    subnet_id       = aws_subnet.public-subnet-1a.id

    tags = {
      Name = "${var.environment}-NAT-Gateway"
    }

    depends_on = [ aws_eip.elastic-ip-for-nat-gateway ]
}

# Internet Gateway Creation

resource "aws_internet_gateway" "main-igw" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "${var.environment}-IGW"
    }
}


# Nat Gateway & route table association [ private route]

resource "aws_route" "nat-gw-route" {
    route_table_id          = aws_route_table.private-route-table.id
    nat_gateway_id          = aws_nat_gateway.nat-gw.id
    destination_cidr_block  = "0.0.0.0/0"
}

# Public IGW & route table association [ public route]

resource "aws_route" "igw-route" {
    route_table_id          = aws_route_table.public-route-table.id
    gateway_id              = aws_internet_gateway.main-igw.id
    destination_cidr_block  = "0.0.0.0/0"
}
