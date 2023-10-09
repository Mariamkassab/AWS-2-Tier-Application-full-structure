variable "aws_lb_arn" {
  type = string
  description = "ARN of your LoadBalance that you want to attach with WAF"
}

variable "waf-name" {
  type = string
}

variable "waf-log-group-name" {
  type = string
}