# Elastic IP (optional)
resource "aws_eip" "ip" {
  vpc       = true
  instance	= aws_instance.jenkins.id
}

# Create a VPC
resource "aws_vpc" "vpc10" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "vpc10"
  }
}

# Create Subnet
resource "aws_subnet" "subnet10" {
  vpc_id = aws_vpc.vpc10.id
  cidr_block = "10.10.10.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet10"
  }
}

# Add 0.0.0.0/0 to default routing table
resource "aws_default_route_table" "r" {
  default_route_table_id = aws_vpc.vpc10.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw10.id
  }

  tags = {
    Name = "main"
  }
}

# Create IGW for VPC
resource "aws_internet_gateway" "gw10" {
  vpc_id = aws_vpc.vpc10.id

  tags = {
    Name = "main"
  }
}

# Create Security Group
resource "aws_security_group" "jenkins" {
  vpc_id      = aws_vpc.vpc10.id

  ingress {
    # SSH Port 22 allowed from any IP
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH from any"
  }

  ingress {
    # HTTP
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP from any"
  }

  ingress {
    # HTTPS
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPs from any"
  }

  ingress {
    # Jenkins
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Jenkins from any"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow to all"
  }
}