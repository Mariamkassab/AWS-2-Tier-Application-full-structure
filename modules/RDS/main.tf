resource "aws_db_subnet_group" "subnet-group" {
  name       = "subnet-group"
  subnet_ids = var.subnet-vpc-id 

  tags = {
    Name = "subnet-group"
  }
}

resource "aws_db_instance" "mysql-rds" {
  engine               = var.engine-name 
  identifier           = var.db-name 
  allocated_storage    =  var.storage 
  engine_version       = var.engine-v 
  instance_class       = var.instance-type 
  username             = var.user 
  password             = var.pass 
  vpc_security_group_ids = [var.db-security-group] 
  skip_final_snapshot  = var.skip-final-db-snapshot 
  publicly_accessible =  false
  db_subnet_group_name  = aws_db_subnet_group.subnet-group.name
  iam_database_authentication_enabled = true
}