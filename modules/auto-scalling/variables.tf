variable "lanch-temp-name" {
  type = string
}

variable "user-data" {
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

variable "security-group" {
  type = string
}

variable "asg-name" {
  type = string
}
variable "subnet-id" {
  type = list
}

variable "max-size" {
  type = any
}

variable "min-size" {
  type = any
}

variable "desired-no" {
  type = any
}
variable "grace-period" {
  type = any
}

variable "target-group" {
  type = any
}

variable "name-prefix" {
  type = string
}