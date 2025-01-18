# VPC Resource
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-main"
  }
}

# Public Subnet Resources
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.env}-public-${var.azs[count.index]}"
  }
}

# Private Subnet Resources
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.env}-private-${var.azs[count.index]}"
  }
}

# Internet Gateway Resource
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

# Public Route Table for internet access
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

# Route for Public Subnets to Access the Internet
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Associate Public Subnets with the Public Route Table
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

#NAT Gateway is needed if we impl RDS or other resources which would require a private gateway for secure connection. 

# Private Route Table (If you have a NAT Gateway or other routing, add it here)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
}

# If you are using a NAT Gateway, you would add routes for private subnets like this:
# resource "aws_route" "private_nat" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_nat_gateway.this.id
# }

# Output VPC ID
output "vpc_id" {
  value = aws_vpc.this.id
}

# Output IDs of Private Subnets
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

# Output IDs of Public Subnets
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
