variable "vpc_id" {
  type        = string
  description = "value of the vpc id"
}

variable "alb_name" {
  type = string
  default = "value of the alb name"
}

variable "sg_elb_name" {
  type        = string
  description = "value of the security group name"
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "value of the vpc subnet ids"
}

variable "egress_cidr_ipv4" {
  type        = string
  default     = "0.0.0.0/0"
  description = "value of the egress cidr ipv4"
}

variable "certificate_arn" {
  type        = string
  description = "value of the certificate arn"
}