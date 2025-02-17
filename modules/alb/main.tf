resource "aws_lb" "alb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.subnet1_id, var.subnet2_id]

  tags = {
    Name = "app-lb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_listener" "listener1" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
resource "aws_lb_target_group_attachment" "web_instance" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance_id
  port             = 80
}
