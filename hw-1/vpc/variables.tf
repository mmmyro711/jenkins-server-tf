# VPC Variables
variable "vpc_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "pub_rt_name" {
  type = string
}

variable "prv_rt_name" {
  type = string
}

# Public Subnet 1 Variables
variable "pub_subnet_1_cidr" {
  type = string
}

variable "pub_subnet_1_name" {
  type = string
}

# Private Subnet 1 Variables
variable "prv_subnet_1_cidr" {
  type = string
}

variable "prv_subnet_1_name" {
  type = string
}