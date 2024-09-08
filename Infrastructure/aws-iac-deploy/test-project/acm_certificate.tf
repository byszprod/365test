resource "aws_acm_certificate" "alb_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  key_algorithm     = "EC_secp384r1"

  tags = {
    Name = "Alb_Certificate"
  }
}

resource "aws_route53_record" "acm_record" {
  for_each = {
    for dvo in aws_acm_certificate.alb_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 1
  type            = each.value.type
  zone_id         = module.route53.route53_zone_id
}

# Cant validate in fastly way

# resource "aws_acm_certificate_validation" "acm_certificate_validation" {
#   certificate_arn         = aws_acm_certificate.alb_certificate.arn
#   validation_record_fqdns = [for record in aws_route53_record.acm_record : record.fqdn]
# }