variable "aws-region" {
  type = string
}


variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}
variable "gw_name" {
  type = string
}


variable "subnet_cidr" {
    type = list  
}
variable "subnet_name" {
  type = list
}
variable "az" {
  type = list
}
variable "nat_name" {
  type = string
}


variable "pub-wanted-cidr" {
  type = string
}
variable "pub-table-name" {
  type = string
}

variable "pri-wanted-cidr" {
  type = string
}
variable "pri-table-name" {
  type = string
}


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



variable "include_global_service_events" {
  type = bool
}



