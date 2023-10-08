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

variable "subnet-vpc-id" {
  type = any
}
variable "skip-final-db-snapshot" {
  type = bool
}

variable "db-security-group" {
  type = any
}