resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.common_tags,
    {
      Name = var.vpc_name
  })
}

resource "aws_subnet" "private-1" {
  availability_zone = var.subnet_prefix.subnet-1["az"]
  cidr_block        = var.subnet_prefix.subnet-1["cidr"]
  vpc_id            = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-subnet-1"
  })
}

resource "aws_subnet" "private-2" {
  availability_zone = var.subnet_prefix.subnet-2["az"]
  cidr_block        = var.subnet_prefix.subnet-2["cidr"]
  vpc_id            = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-subnet-2"
  })
}

resource "aws_subnet" "private-3" {
  availability_zone = var.subnet_prefix.subnet-3["az"]
  cidr_block        = var.subnet_prefix.subnet-3["cidr"]
  vpc_id            = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-subnet-3"
  })
}


resource "aws_subnet" "public-1" {
  count = var.igw_enabled ? 1 : 0

  availability_zone = var.subnet_prefix_public.public-subnet-1["az"]
  cidr_block        = var.subnet_prefix_public.public-subnet-1["cidr"]
  vpc_id            = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-public-subnet-1"
  })
}

resource "aws_subnet" "public-2" {
  count = var.igw_enabled ? 1 : 0

  availability_zone = var.subnet_prefix_public.public-subnet-2["az"]
  cidr_block        = var.subnet_prefix_public.public-subnet-2["cidr"]
  vpc_id            = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-public-subnet-2"
  })
}

resource "aws_security_group" "sg" {
  name        = "Allow HTTPS"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Squid port"
    from_port   = 3128
    to_port     = 3128
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-Allow_HTTPS"
  })
}

resource "aws_internet_gateway" "igw" {
  count  = var.igw_enabled ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-IGW"
  })
}

resource "aws_eip" "eip-01" {
  count = var.igw_enabled ? 1 : 0
  vpc   = true
}

resource "aws_eip" "eip-02" {
  count = var.igw_enabled ? 1 : 0
  vpc   = true
}

resource "aws_nat_gateway" "nat-1" {
  count         = var.igw_enabled ? 1 : 0
  allocation_id = aws_eip.eip-01[0].id
  subnet_id     = aws_subnet.public-1[0].id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-nat-subnet-1"
  })
}

resource "aws_nat_gateway" "nat-2" {
  count         = var.igw_enabled ? 1 : 0
  allocation_id = aws_eip.eip-02[0].id
  subnet_id     = aws_subnet.public-2[0].id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-nat-subnet-2"
  })
}

resource "aws_route_table" "public-1" {
  count  = var.igw_enabled ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-public-1"
  })
}

resource "aws_route_table" "public-2" {
  count  = var.igw_enabled ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-public-2"
  })
}

resource "aws_route_table_association" "public-1" {
  count          = var.igw_enabled ? 1 : 0
  subnet_id      = aws_subnet.public-1[0].id
  route_table_id = aws_route_table.public-1[0].id
}

resource "aws_route_table_association" "public-2" {
  count          = var.igw_enabled ? 1 : 0
  subnet_id      = aws_subnet.public-2[0].id
  route_table_id = aws_route_table.public-2[0].id
}

resource "aws_route_table" "private-01" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-private-1"
  })
}

resource "aws_route_table" "private-02" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-private-2"
  })
}

resource "aws_route_table" "private-03" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-private-3"
  })
}

resource "aws_route" "rt-1-igw" {
  count                  = var.igw_enabled ? 1 : 0
  route_table_id         = aws_route_table.private-01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-1[0].id
}

resource "aws_route" "rt-2-igw" {
  count                  = var.igw_enabled ? 1 : 0
  route_table_id         = aws_route_table.private-02.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-2[0].id
}

resource "aws_route" "rt-3-igw" {
  count                  = var.igw_enabled ? 1 : 0
  route_table_id         = aws_route_table.private-03.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-2[0].id
}


resource "aws_route_table_association" "private-01" {
  count          = var.igw_enabled ? 1 : 0
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private-01.id
}

resource "aws_route_table_association" "private-02" {
  count          = var.igw_enabled ? 1 : 0
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private-02.id
}

resource "aws_route_table_association" "private-03" {
  count          = var.igw_enabled ? 1 : 0
  subnet_id      = aws_subnet.private-3.id
  route_table_id = aws_route_table.private-03.id
}


