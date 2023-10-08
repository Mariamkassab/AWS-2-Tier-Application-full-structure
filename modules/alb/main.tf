resource "aws_lb" "lb_creation" {
  name               = var.lb_name
  internal           = var.internal_or
  load_balancer_type = var.lb_type
  security_groups    = var.lb_sg
  subnets            = var.pub_subnets   #[for subnet in var.which_sub[count.index] : var.subnet_ids[count.index]]



  tags = {
    Environment = var.lb_env
  }
}   

resource "aws_lb_target_group" "lb_tg" {
  name     = var.tg_name
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.created_vpc_id
}

resource "aws_lb_listener" "lb_l" {
  load_balancer_arn = aws_lb.lb_creation.arn
  port              = var.tg_port
  protocol          = var.tg_protocol
  default_action {
    type             = var.default_action_type
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}
