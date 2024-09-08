resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "Main VPC"
  }
}

### Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main IGW"
  }
}

# NAT Gateway

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)

  tags = {
    Name = "Main NAT Gateway"
  }

  depends_on = [aws_subnet.public_subnet]
}

### Public Subnets

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets_cidr)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${element(var.availability_zones, count.index)}"
  }
}
resource "aws_route_table" "main_public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_subnet_route" {
  route_table_id         = aws_route_table.main_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.public_subnets_cidr)

  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.main_public.id
}


### Private Subnets

resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_subnets_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet ${element(var.availability_zones, count.index)}"
  }
}

resource "aws_route_table" "main_private" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "private_subnet_nat_gateway" {
  route_table_id         = aws_route_table.main_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.main_private.id
}


### Netrwork ACLs if needs

# resource "aws_network_acl" "public" {
#   vpc_id = aws_vpc.main.id
# }

# resource "aws_network_acl_rule" "acl_80" {
#   network_acl_id = aws_network_acl.public.id
#   rule_number    = 200
#   egress         = false
#   protocol       = "tcp"
#   rule_action    = "allow"
#   cidr_block     = aws_vpc.main.cidr_block
#   from_port      = 80
#   to_port        = 80
# }

# resource "aws_network_acl_rule" "acl_443" {
#   network_acl_id = aws_network_acl.public.id
#   rule_number    = 201
#   egress         = false
#   protocol       = "tcp"
#   rule_action    = "allow"
#   cidr_block     = aws_vpc.main.cidr_block
#   from_port      = 443
#   to_port        = 443
# }
