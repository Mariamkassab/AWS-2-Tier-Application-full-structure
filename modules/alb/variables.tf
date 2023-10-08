variable "lb_name" {
  type = string
}

variable "internal_or" {
  type = bool
}

variable "lb_type" {
  type = string
}

variable "lb_sg" {
  type = any
}

variable "pub_subnets" {
  type = list   ######
}


variable "lb_env" {
  type = string
}

variable "tg_name" {
  type = any
}

variable "tg_port" {
  type = number
}

variable "tg_protocol" {
  type = string
}

variable "created_vpc_id" {
  type = any
}


variable "default_action_type" {
    type = string
}


