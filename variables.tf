
# provider
variable "aws-region" {
  type = string
}


#vpc
variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "gw_name" {
  type = string
}


#subnets
variable "subnet_cidr" {
    type = list  
}
variable "subnet_name" {
  type = list
}
variable "az" {
  type = list
}


#nat
variable "nat_name" {
  type = string
}


# ec2 security group
variable "ec2-ssh-cidr" {
  type = list
}
variable "ec2-rds-cidr" {
  type = list
}


# lb security groupe
variable "lb-ec2-cidr" {
  type = list
}


#public rt
variable "pub-wanted-cidr" {
  type = string
}
variable "pub-table-name" {
  type = string
}

#private rt
variable "pri-wanted-cidr" {
  type = string
}
variable "pri-table-name" {
  type = string
}


#loadbalancer
variable "lb_name" {
  type = string
}
variable "internal_or" {
  type = bool
}
variable "lb_type" {
  type = string
}
variable "lb_env" {
  type = string
}
variable "tg_name" {
  type = string
}
variable "tg_port" {
  type = any
}
variable "tg_protocol" {
  type = string
}
variable "default_action_type" {
  type = string
}


# autoscalling group
variable "lanch-temp-name" {
  type = string
}
variable "name-prefix" {
  type = string
}
variable "image-id" {
  type = string
}
variable "ec2-type" {
  type = string
}
variable "key-name" {
  type = string
}
variable "user-data" {
  type = string
}
variable "asg-name" {
  type = string
}
variable "max-size" {
  type = any
}
variable "min-size" {
  type = any
}
variable "grace-period" {
  type = any
}
variable "desired-no" {
  type = any
}
variable "ec2-name" {
  type = string
}



# rds
variable "engine-name" {
  type = string
}
variable "db-name" {
  type = string
}
variable "storage" {
  type = string
}
variable "engine-v" {
  type = any
}
variable "instance-type" {
  type = string
}
variable "user" {
  type = any
}
variable "pass" {
  type = any
}
variable "skip-final-db-snapshot" {
  type = bool
}
variable "max_allocated_storage-autoscalling" {
  type = any
}
variable "monitoring_interval" {
  type = any
}
variable "maintenance_window" {
  type = any
}
variable "backup_window" {
  type = any
}
variable "backup_retention_period" {
  type = any
}





