### General variables
variable "region" {
  type = string
}

### VPC variables
variable "cidr_block" {
  type        = string
  description = "value of the cidr block"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "value of the public subnets cidr"
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "value of the private subnets cidr"
}

variable "availability_zones" {
  type        = list(string)
  description = "value of the availability zones"
}

### ALB variables
variable "sg_elb_name" {
  type        = string
  description = "value of the security group name"
}

variable "alb_name" {
  type    = string
  default = "value of the alb name"
}

### Route53 variables
variable "domain_name" {
  type        = string
  description = "value of the domain name"
}

variable "common_tags" {
  description = "Common tags applied to all components"
  type        = map(string)
}
### End