// Create vpc
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "jenkins-server-vpc"
  }
}
// Public/PRIVATE subnets
resource "aws_subnet" "public" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_cidr_block, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "public-${count.index}"
  }
}
resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_cidr_block, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "private-${count.index}"
  }
}
// Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Route all outbound traffic to the internet gateway
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "public_rt"
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" # Route all outbound traffic to the internet gateway
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "private_rt"
  }
}

// Public Subnet Association

resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

// Private Subnet Association

resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

// Internet gw
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my_igw"
  }
}
// elastic ip
resource "aws_eip" "lb" {
  instance = aws_instance.myjenkins_server.id
  domain   = "vpc"
}
// Nat Gateway
# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.lb.id
#   subnet_id     = aws_subnet.public[0].id

#   tags = {
#     Name = "NAT gw"
#   }
# }
// Route table 
# resource "aws_route_table" "main" {
#   vpc_id = aws_vpc.main.id

#   # Define the routes
#   route {
#     cidr_block = "0.0.0.0/0"    # Route all outbound traffic to the internet gateway
#     gateway_id = aws_internet_gateway.myigw.id
#   }
#   tags = {
#     Name = "route-table"
#   }
# }

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.public[0].id # Specify the subnet ID
  route_table_id = aws_route_table.public.id
}