module "route53" {
  source      = "../shared_modules/aws_route53"
  domain_name = var.domain_name
}