resource "aws_iam_role" "rds_auth_role" {
  name = "rds_auth_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_rds_role_policy" {
  role       = aws_iam_role.rds_auth_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "attach_cw_role_policy" {
  role       = aws_iam_role.rds_auth_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

 resource "aws_iam_instance_profile" "ec2-access-rds" {
   name = "ec2-access-rds"
   role = aws_iam_role.rds_auth_role.name
 }


resource "aws_launch_template" "lanuch-temp" {
  name = var.lanch-temp-name 
  #name_prefix = var.name-prefix 
  image_id = var.image-id
  instance_type = var.ec2-type 
  key_name = var.key-name 
  monitoring {
    enabled = true
  }
  iam_instance_profile {
    #name = aws_iam_instance_profile.ec2-access-rds.name
    arn = aws_iam_instance_profile.ec2-access-rds.arn
  }
  # provisioner "file" {
  #   source      = "./modules/config.json"
  #   destination = "/opt/aws/amazon-cloudwatch-agent/bin/config.json"
  # }
  vpc_security_group_ids = [var.security-group]
  user_data = filebase64 (var.user-data)
}


resource "aws_autoscaling_group" "ASG" {
  name                      = var.asg-name 
  depends_on                = [aws_launch_template.lanuch-temp , aws_key_pair.generated_key]
  vpc_zone_identifier       = var.subnet-id 
  max_size                  = var.max-size 
  min_size                  = var.min-size 
  health_check_grace_period = var.grace-period 
  health_check_type         = "EC2"
  desired_capacity          = var.desired-no 
  launch_template {
    id      = aws_launch_template.lanuch-temp.id
    version = "$Latest"
  }
  target_group_arns         = [var.target-group]

}

resource "aws_autoscaling_policy" "asg-policy" {
  name                   = "asg-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ASG.name
}



resource "tls_private_key" "tls_private_k" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key-name
  public_key = tls_private_key.tls_private_k.public_key_openssh
}


resource "local_file" "private_key_file" {
  filename = "./ec2-key.pem"
  content  = tls_private_key.tls_private_k.private_key_pem
}