# LIST DOWN AVAILABLE ZONES
data "aws_availability_zones" "list" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name          = format("%s_%s_vpc", local.project_name, local.environment)
    Resource_Role = format("virtual private cloud for %s %s", local.project_name, local.environment)
  }
}

# CREATE 3 PUBLIC SUBNETS ON 3 DIFFERENT AVAILABILITY ZONES
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets) != [] ? length(var.private_subnets) : 0
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.list.names[count.index]
  tags = {
    Name          = format("%s-%s-public-subnet-%s", local.project_name, local.environment, count.index + 1)
    Resource_Role = format("public subnet inside vpc: %s-%s-vpc", local.project_name, local.environment)
  }
}

# CREATE 3 PRIVATE SUBNETS ON 3 DIFFERENT AVAILABILITY ZONES
resource "aws_subnet" "private" {
  count                   = length(var.private_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnets[count.index]
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.list.names[count.index]

  tags = {
    Name          = format("%s-%s-private-subnet-%s", local.project_name, local.environment, count.index + 1)
    Resource_Role = format("private subnet inside vpc: %s-%s-vpc", local.project_name, local.environment)
  }
}

# CREATE PRIVATE SUBNET DEDICATED FOR DATABASE
resource "aws_subnet" "database" {
  count                   = local.create_db_subnets ? length(var.database_subnets) : 0
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.database_subnets[count.index]
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.list.names[count.index]

  tags = {
    Name          = format("%s-data-subnet-%s", local.environment, count.index + 1)
    Resource_Role = format("data subnet group inside vpc: %s-%s-vpc", local.project_name, local.environment)
  }
}

#CREATE AN ELASTIC IP
resource "aws_eip" "nat_eip" {
  count = var.enable_nat ? 1 : 0

  tags = {
    Name          = format("%s_%s_nat_elastic_ip", local.project_name, local.environment)
    Resource_Role = format("elastic ip for nat gateway in vpc: %s_%s_vpc", local.project_name, local.environment)
  }
}

# CREATE A NAT GATEWAY
resource "aws_nat_gateway" "nat" {
  count         = var.enable_nat ? 1 : 0
  allocation_id = aws_eip.nat_eip[0].id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name          = format("%s_%s_nat_gateway", local.project_name, local.environment)
    Resource_Role = format("nat gateway inside vpc: %s_%s_vpc", local.project_name, local.environment)
  }
}

# CREATE A ROUTE TABLE FOR PRIVATE SUBNETS
resource "aws_route_table" "private" {
  count  = length(var.private_subnets) != [] ? 1 : 0
  vpc_id = aws_vpc.this.id
  dynamic "route" {
    for_each = var.enable_nat ? local.route : []
    content {
      cidr_block     = route.value.cidr_block
      nat_gateway_id = aws_nat_gateway.nat[0].id
    }
  }

  tags = {
    Name          = format("%s-%s-rt-private", local.project_name, local.environment)
    Resource_Role = format("private route table inside vpc: %s-%s-vpc", local.project_name, local.environment)
  }
}

# CREATE A ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets) != [] ? length(aws_subnet.private) : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private[0].id
}

# CREATE AN INTERNET GATEWAY
resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name          = format("%s-%s-internet-gateway", local.project_name, local.environment)
    Resource_Role = format("internet gateway for vpc: %s-%s-vpc", local.project_name, local.environment)
  }
}

#CREATE A PUBLIC ROUTE TABLE
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet.id
  }
  tags = {
    Name          = format("%s-%s-rt-public", local.project_name, local.environment)
    Resource_Role = format("route table public for: %s-%s-vpc", local.project_name, local.environment)
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id

  ingress {
    protocol    = -1
    self        = true
    from_port   = 0
    to_port     = 0
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }
}

