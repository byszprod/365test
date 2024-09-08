resource "aws_security_group" "sg_elb" {
  vpc_id = var.vpc_id
  name   = var.sg_elb_name
  tags = {
    Name = "${var.sg_elb_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sg_elb_ingress_80" {
  security_group_id = aws_security_group.sg_elb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "sg_elb_ingress_443" {
  security_group_id = aws_security_group.sg_elb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}


resource "aws_vpc_security_group_egress_rule" "sg_elb_egress" {
  security_group_id = aws_security_group.sg_elb.id

  cidr_ipv4   = var.egress_cidr_ipv4
#   from_port   = All
  ip_protocol = -1
#   to_port     = All
}

resource "aws_lb" "app_lb" {
    name               = var.alb_name
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.sg_elb.id]
    subnets            = var.vpc_subnet_ids
}

resource "aws_lb_target_group" "app_tg" {
    name     = "app-target-group"
    port     = 443
    protocol = "HTTPS"
    vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http_listener" {
    load_balancer_arn = aws_lb.app_lb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type = "redirect"

        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

### Need correct acm certificate validation

# resource "aws_lb_listener" "https_listener" {
#     load_balancer_arn = aws_lb.app_lb.arn
#     port              = 443
#     protocol          = "HTTPS"

#     ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
#     certificate_arn = var.certificate_arn

#     default_action {
#         type             = "forward"
#         target_group_arn = aws_lb_target_group.app_tg.arn
#     }
# }
