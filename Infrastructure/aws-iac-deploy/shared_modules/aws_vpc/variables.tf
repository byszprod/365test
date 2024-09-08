variable "region" {
  type        = string
  description = "value of the region"
}

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