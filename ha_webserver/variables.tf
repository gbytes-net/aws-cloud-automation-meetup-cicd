variable "ami_id" {
  type = string
  description = "The AMI ID to use for EC2"
}
variable "application_name" {
  type = string
  description = "The name of the project using this module"
}

variable "webserver_domain_zone" {
  type = string
}

variable "webserver_domain" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet1_id" {
  type = string
}

variable "public_subnet2_id" {
  type = string
}