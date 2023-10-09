resource "aws_ec2_instance_connect_endpoint" "ec2-connect" {
  subnet_id = var.sub-id # should be var 
  security_group_ids = var.endpoint-security-group
  tags = { 
    Name = var.vpc-endpoint-name
  }
}
