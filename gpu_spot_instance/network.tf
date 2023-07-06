resource "aws_vpc" "vps-env" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "subnet-uno" {
  # creates a subnet
  cidr_block        = cidrsubnet(aws_vpc.vps-env.cidr_block, 3, 1)
  vpc_id            = aws_vpc.vps-env.id
  availability_zone = var.aws_availability_zone
}

resource "aws_security_group" "ingress-ssh-vps" {
  name   = "allow-ssh-sg"
  vpc_id = aws_vpc.vps-env.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress-http-vps" {
  name   = "allow-http-sg"
  vpc_id = aws_vpc.vps-env.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress-https-vps" {
  name   = "allow-https-sg"
  vpc_id = aws_vpc.vps-env.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 443
    to_port   = 443
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "vps-env-gw" {
  vpc_id = aws_vpc.vps-env.id
}

resource "aws_route_table" "route-table-vps-env" {
  vpc_id = aws_vpc.vps-env.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vps-env-gw.id
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet-uno.id
  route_table_id = aws_route_table.route-table-vps-env.id
}
