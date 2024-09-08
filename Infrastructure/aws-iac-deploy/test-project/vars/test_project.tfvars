### Provider configuration
region = "eu-central-1"

### ALB configuration
sg_elb_name = "test-project-alb-sg"
alb_name    = "test-project-alb"

### Route53 configuration
domain_name = "testproject365.io"

### VPC configuration
cidr_block = "172.16.0.0/16"
public_subnets_cidr = ["172.16.1.0/24", "172.16.4.0/24"]
private_subnets_cidr = ["172.16.13.0/24", "172.16.14.0/24"]
availability_zones = ["eu-central-1b", "eu-central-1c"]

common_tags = {
  Owner = "365Scores"
  Environment = "test"
  Project = "test-project"
  ManagedBy = "Terraform"
}