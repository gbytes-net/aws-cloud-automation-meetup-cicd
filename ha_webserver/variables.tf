variable "availability_zones" {
  type = list(string)

  description = "the availability zone names for the region"
}

variable "user_data_1" {
  type = string
  description = "path to the user_data file to use to configure EC2"
}

variable "ami_id" {
  type = string
  description = "The AMI ID to use for EC2"
}
variable "project" {
  type = string
  description = "The name of the project using this module"
}

variable "webserver_domain_zone" {
  type = string
}

variable "webserver_domain" {
  type = string
}