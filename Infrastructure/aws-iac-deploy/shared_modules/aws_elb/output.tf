output "elb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "elb_arn" {
  value = aws_lb.app_lb.arn
}

output "elb_zone_id" {
  value = aws_lb.app_lb.zone_id
}