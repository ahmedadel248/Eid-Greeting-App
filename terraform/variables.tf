variable "aws_region" {

  type = string

}

variable "vpc_cidr" {

  type = string

}

variable "subnet_cidrs" {

  type = list(string)

}

variable "availability_zones" {

  type = list(string)

}


variable "instance_type" {

  type = string

}