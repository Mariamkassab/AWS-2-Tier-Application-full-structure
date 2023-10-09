# resource "random_password" "master"{
#   length           = 16
#   special          = true
#   override_special = "_!%^"
# }

# resource "aws_secretsmanager_secret" "rds-password" {
#   name = "db-password"
#   recovery_window_in_days = 0
# }

# resource "aws_secretsmanager_secret_version" "password" {
#   secret_id = aws_secretsmanager_secret.rds-password.id
#   secret_string = random_password.master.result
# }

# data "aws_secretsmanager_secret" "secretmasterDB" {
#   arn = aws_secretsmanager_secret.secretmasterDB.arn
# }
  
# data "aws_secretsmanager_secret_version" "creds" {
#   secret_id = data.aws_secretsmanager_secret.secretmasterDB.arn
# }



resource "aws_iam_role" "rds_enhanced_monitoring" {
  name_prefix        = "rds-enhanced-monitoring-"
  assume_role_policy = data.aws_iam_policy_document.rds_enhanced_monitoring.json
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = aws_iam_role.rds_enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}



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
  #max_allocated_storage = 100  # this is for rds autoscaling   #var.max_allocated_storage-autoscalling
  engine_version       = var.engine-v 
  instance_class       = var.instance-type 
  username             = var.user 
  password             = var.pass #aws_secretsmanager_secret_version.password.secret_string  #var.pass
  vpc_security_group_ids = [var.db-security-group] 
  skip_final_snapshot  = var.skip-final-db-snapshot 
  publicly_accessible =  false
  db_subnet_group_name  = aws_db_subnet_group.subnet-group.name
  iam_database_authentication_enabled = true
  ca_cert_identifier = "rds-ca-rsa4096-g1"  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL-certificate-rotation.html#:~:text=If%20you%20are%20using%20a,its%20certificate%20after%20July%2028%2C
  #https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html#:~:text=a%20DB%20instance.-,Certificate%20authority%20(CA),Description,-rds%2Dca%2D2019
  multi_az = true
  monitoring_interval = 30                                 #var.monitoring_interval
  monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring.arn
  enabled_cloudwatch_logs_exports = ["audit", "general"]
  #maintenance_window              = "Mon:00:00-Mon:03:00" #var.maintenance_window 
  #backup_window                   = "03:00-06:00"         #var.backup_window
  #backup_retention_period = 0                             #var.backup_retention_period
  lifecycle {
        #prevent_destroy = true
   }
}