resource "aws_vpc" "sporter-vpc-1" {
  cidr_block = "10.120.0.0/16"

  tags = {
    Name = "sporter-vpc-1"
    terraform = "managed"
  }
}

resource "aws_subnet" "sporter-subnet1" {
  vpc_id                  = aws_vpc.sporter-vpc-1.id
  cidr_block              = "10.120.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "sporter-subnet1"
    terraform = "managed"
  }
}

resource "aws_subnet" "sporter-subnet2" {
  vpc_id                  = aws_vpc.sporter-vpc-1.id
  cidr_block              = "10.120.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "sporter-subnet2"
    terraform = "managed"
  }
}

output "vpc1-id" {
  value = aws_vpc.sporter-vpc-1.id
}

output "subnet1-id" {
  value = aws_subnet.sporter-subnet1.id
}

output "subnet2-id" {
  value = aws_subnet.sporter-subnet2.id
}