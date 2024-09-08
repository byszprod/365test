module "alb" {
  source = "../shared_modules/aws_elb"

  alb_name         = var.alb_name
  vpc_id           = module.vpc.vpc_id
  sg_elb_name      = var.sg_elb_name
  vpc_subnet_ids   = module.vpc.public_subnet_ids
  egress_cidr_ipv4 = module.vpc.cidr_block
  certificate_arn  = aws_acm_certificate.alb_certificate.arn

  depends_on = [module.vpc, aws_acm_certificate.alb_certificate]
}

resource "aws_route53_record" "lb_record" {
  zone_id = module.route53.route53_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = module.alb.elb_dns_name
    zone_id                = module.alb.elb_zone_id
    evaluate_target_health = false
  }

  depends_on = [module.alb, module.route53]
}