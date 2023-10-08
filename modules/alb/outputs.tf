output "lb_target_group_arn" {
  value = aws_lb_target_group.lb_tg.arn
}


output "lb_dns" {
  value = aws_lb.lb_creation.dns_name
}

output "lb_arn" {
  value = aws_lb.lb_creation.arn
}