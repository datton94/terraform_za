resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id
}

resource "aws_route_table" "prod_public_crt" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    //machine in this subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.prod_igw.id
  }
}

resource "aws_route_table_association" "prod_crta_public_subnet_1" {
  subnet_id      = aws_subnet.prod_subnet_public_1.id
  route_table_id = aws_route_table.prod_public_crt.id
}

resource "aws_security_group" "ssh_http_allowed" {
  vpc_id = aws_vpc.prod_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // All ip address are allowed to ssh ! 
    cidr_blocks = ["0.0.0.0/0"]
  }
  // Allow access to webservice
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "database_connection_allowed" {
  vpc_id = aws_vpc.prod_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    // All ip address are allowed to ssh ! 
    cidr_blocks = ["10.63.1.0/24"]
  }
}