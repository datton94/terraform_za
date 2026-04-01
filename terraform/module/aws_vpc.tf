resource "aws_vpc" "prod_vpc" {
  cidr_block           = "10.63.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "prod_vpc"
  }
}

resource "aws_subnet" "prod_subnet_public_1" {
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = "10.63.1.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = var.availability_zones[0]
}

resource "aws_subnet" "prod_subnet_public_2" {
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = "10.63.10.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = var.availability_zones[1]
}

resource "aws_subnet" "prod_subnet_public_3" {
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = "10.63.20.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = var.availability_zones[2]
}

resource "aws_subnet" "prod_subnet_private_1" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.63.2.0/24"
  availability_zone = var.availability_zones[0]
}