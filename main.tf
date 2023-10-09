module "terraform_vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  gw_name  = var.gw_name
}

module "terraform_subnet" {
  source         = "./modules/subnet"
  created_vpc_id = module.terraform_vpc.vpc_id
  subnet_cidr    = var.subnet_cidr
  az             = var.az
  subnet_name    = var.subnet_name
}

module "nat_gateway" {
  source           = "./modules/nat"
  public_subnet_id = module.terraform_subnet.first_pub_id
  nat_name         = var.nat_name
}

module "ec2_security_group" {
  source         = "./modules/security-group"
  created_vpc_id = module.terraform_vpc.vpc_id

  ingress_rules = {
    ssh = {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = []
      security_group = [module.endpoint_security_group.sg_id]
    },
    lb = {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = [] 
      security_group = [module.lb_security_group.sg_id]
    }
  }

  egress_rules = { 
    all = {
      port        = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      security_group = []
    }
  }

  sc_g_name = "ec2_security_group"
}



module "rds_security_group" {
  source         = "./modules/security-group"
  created_vpc_id = module.terraform_vpc.vpc_id

  ingress_rules = {
    ec2 = {
      port        = 3306
      protocol    = "tcp"
      cidr_blocks = []
      security_group = [module.ec2_security_group.sg_id] 
    }
  }

  egress_rules = {
    no-rules = {
      port        = 0
      protocol    = ""
      cidr_blocks = []
      security_group = []

    }
  }

  sc_g_name = "rds_security_group"
}

module "lb_security_group" {
  source         = "./modules/security-group"
  created_vpc_id = module.terraform_vpc.vpc_id

  ingress_rules = {
    html = {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
      security_group = []
    }
  }

  egress_rules = {
    ec2 = {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = var.lb-ec2-cidr 
      security_group = []
    }
  }

  sc_g_name = "lb_security_group"
}


module "endpoint_security_group" {
  source         = "./modules/security-group"
  created_vpc_id = module.terraform_vpc.vpc_id

  ingress_rules = {
    no-rules = {
      port        = 0
      protocol    = ""
      cidr_blocks = []   # my public ip
      security_group = [] 
    }
  }

  egress_rules = {
    ec2 = {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = var.endpoint-ssh-cidr
      security_group = []

    }
  }

  sc_g_name = "endpoint_security_group"
}

module "public_routing_table" {
  source         = "./modules/route_table"
  created_vpc_id = module.terraform_vpc.vpc_id
  wanted_cidr    = var.pub-wanted-cidr 
  needed_gatway  = module.terraform_vpc.internet_gateway_id
  table_name     = var.pub-table-name
  chosen_subnets  = [module.terraform_subnet.first_pub_id , module.terraform_subnet.second_pub_id]
   } 


module "private_routing_table" {
  source         = "./modules/route_table"
  created_vpc_id = module.terraform_vpc.vpc_id
  wanted_cidr    = var.pri-wanted-cidr 
  needed_gatway  = module.nat_gateway.nat_id
  table_name     = var.pri-table-name 
  chosen_subnets  = [module.terraform_subnet.first_pri_id, module.terraform_subnet.second_pri_id]
   } 



module "lbs_creation" {
  source = "./modules/alb"
  lb_name = var.lb_name
  internal_or = var.internal_or
  lb_type = var.lb_type
  lb_sg = [module.lb_security_group.sg_id ]  
  pub_subnets = [module.terraform_subnet.first_pub_id , module.terraform_subnet.second_pub_id ] 
  lb_env = var.lb_env
  tg_name = var.tg_name
  tg_port = var.tg_port
  tg_protocol = var.tg_protocol
  created_vpc_id = module.terraform_vpc.vpc_id
  default_action_type = var.default_action_type
}


module "auto_scaling_group" {
  source = "./modules/auto-scalling"  
  lanch-temp-name = var.lanch-temp-name
  name-prefix = var.name-prefix
  image-id = var.image-id
  ec2-type = var.ec2-type
  key-name = var.key-name
  security-group =  "${module.ec2_security_group.sg_id}"
  user-data = var.user-data 
  asg-name = var.asg-name
  subnet-id = [ module.terraform_subnet.first_pri_id, module.terraform_subnet.second_pri_id ]
  max-size = var.max-size
  min-size = var.min-size
  grace-period = var.grace-period
  desired-no = var.desired-no
  target-group = "${module.lbs_creation.lb_target_group_arn}"
  ec2-name = var.ec2-name
}


# module "mysql-rds" {
#   source = "./modules/RDS"
#   engine-name = var.engine-name
#   db-name = var.db-name
#   storage = var.storage
#   engine-v = var.engine-v
#   instance-type = var.instance-type
#   user = var.user
#   pass = var.pass 
#   subnet-vpc-id = [ module.terraform_subnet.second_pri_id , module.terraform_subnet.first_pri_id ]
#   skip-final-db-snapshot = var.skip-final-db-snapshot
#   db-security-group = module.rds_security_group.sg_id
#   max_allocated_storage-autoscalling = var.max_allocated_storage-autoscalling
#   monitoring_interval = var.monitoring_interval
#   maintenance_window = var.maintenance_window 
#   backup_window = var.backup_window
#   backup_retention_period = var.backup_retention_period
# }

# module "WAF" {
#   source = "./modules/waf"
#   aws_lb_arn = module.lbs_creation.lb_arn
# }

module "ec2-endpoint-az1" {
  source = "./modules/ec2_endpoint"
  sub-id = module.terraform_subnet.first_pri_id # first private subnet
  endpoint-security-group = [module.endpoint_security_group.sg_id]
}
# module "ec2-endpoint-az2" {
#   source = "./modules/ec2_endpoint"
#   sub-id = module.terraform_subnet.second_pri_id   # second private subnet
#   endpoint-security-group = [module.endpoint_security_group.sg_id]
# }

# module "cloudtrail-logs" {
#   source = "./modules/cloudtrail"
# }


