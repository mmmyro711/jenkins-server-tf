# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }

}

# VPC - Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.igw_name
  }

}

# Public Routetable
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = var.pub_rt_name
  }

}

# Private Routetable
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.prv_rt_name
  }
}

# Public Subnet 1 
resource "aws_subnet" "pub_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pub_subnet_1_cidr
  tags = {
    Name = var.pub_subnet_1_name
  }

}

# Public Subnet 1 - Association
resource "aws_route_table_association" "pub_subnet_1" {
  subnet_id      = aws_subnet.pub_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Subnet 1 
resource "aws_subnet" "prv_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.prv_subnet_1_cidr
  tags = {
    Name = var.prv_subnet_1_name
  }

}

# Private Subnet 1 - Association
resource "aws_route_table_association" "prv_subnet_1" {
  subnet_id      = aws_subnet.prv_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}