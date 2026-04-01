
resource "random_password" "password" {
  length  = 8
  special = false
}

resource "aws_db_subnet_group" "prod_subnet_public_1" {
  name       = "main"
  subnet_ids = [aws_subnet.prod_subnet_public_1.id, aws_subnet.prod_subnet_public_2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "postgre" {
  allocated_storage   = var.db_storage_size
  storage_type        = "gp2"
  engine              = var.db_engine
  engine_version      = var.db_engine_version
  instance_class      = "db.t2.micro"
  name                = var.db_name
  username            = var.db_username
  password            = random_password.password.result
  publicly_accessible = true
  availability_zone   = "ap-southeast-1a"
  skip_final_snapshot = true



  db_subnet_group_name   = aws_db_subnet_group.prod_subnet_public_1.name
  vpc_security_group_ids = [aws_security_group.database_connection_allowed.id]
}

