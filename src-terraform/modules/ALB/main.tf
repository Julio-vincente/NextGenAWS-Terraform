resource "aws_lb" "alb_application" {
    name = var.alb_name
    internal = false
    load_balancer_type = "application"
    security_groups = [var.alb_sg]
    subnets = var.subnet_public_alb 
}

resource "aws_lb_listener" "listener_alb_application" {
    load_balancer_arn = aws_lb.alb_application.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "redirect"
      redirect {
        protocol = "HTTPS"
        port = "443"
        status_code = "HTTP_301"
      }
    }
}

resource "aws_lb_target_group" "target_group_alb" {
    name = var.target_name
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "ip"
}

resource "aws_lb_listener" "https_listener" {
    load_balancer_arn = aws_lb.alb_application.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy = ""
    certificate_arn = ""

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.target_group_alb.arn
    }
}