terraform {

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

  }

}

provider "aws" {

  region = var.aws_region

}

# ---------------- Ubuntu AMI ----------------

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {

    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]

  }

  filter {

    name = "virtualization-type"

    values = ["hvm"]

  }

}

# ---------------- VPC ----------------

resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  tags = {
    Name = "Eid-Greeting-VPC"
  }

}

# ---------------- Subnets ----------------

resource "aws_subnet" "main" {

  count = 2

  vpc_id = aws_vpc.main.id

  cidr_block = var.subnet_cidrs[count.index]

  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "Eid-Greeting-Subnet-${count.index + 1}"
  }

}

# ---------------- Internet Gateway ----------------

resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Eid-Greeting-IGW"
  }

}

# ---------------- Route Table ----------------

resource "aws_route_table" "main" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Eid-Greeting-RouteTable"
  }

}

# ---------------- Internet Route ----------------

resource "aws_route" "main" {

  route_table_id = aws_route_table.main.id

  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.main.id

}

# ---------------- Route Table Associations ----------------

resource "aws_route_table_association" "main" {

  count = 2

  subnet_id = aws_subnet.main[count.index].id

  route_table_id = aws_route_table.main.id

}

# ---------------- Security Group ----------------

resource "aws_security_group" "main" {

  name = "eid-greeting-sg"

  description = "Security group for Eid Greeting App"

  vpc_id = aws_vpc.main.id

  # SSH

  ingress {

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  # HTTP

  ingress {

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  # HTTPS

  ingress {

    from_port = 443
    to_port   = 443

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  # Kubernetes API

  ingress {

    from_port = 6443
    to_port   = 6443

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  # NodePort Range

  ingress {

    from_port = 30000
    to_port   = 32767

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "Eid-Greeting-SG"
  }

}

# ---------------- SSH Key Pair ----------------

resource "aws_key_pair" "main" {

  key_name = "eid-key"

  public_key = file("C:/Users/DELL/.ssh/id_ed25519.pub")

}

# ---------------- EC2 Instance ----------------

resource "aws_instance" "eid" {

  count = 1

  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  key_name = aws_key_pair.main.key_name

  subnet_id = aws_subnet.main[0].id

  vpc_security_group_ids = [aws_security_group.main.id]

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | sh -
              EOF

  tags = {
    Name = "Eid-Greeting-Master"
  }

}

# ---------------- Elastic IP ----------------

resource "aws_eip" "main" {

  instance = aws_instance.eid[0].id

  domain = "vpc"

  tags = {
    Name = "Eid-Greeting-EIP"
  }

}
