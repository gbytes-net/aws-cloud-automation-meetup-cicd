#
# arguments for our highly available web server
#
variable "ami_id" {
  type = string
  default = "ami-0a887e401f7654935"
}

variable "availability_zone_1" {
  type = string
  default = "us-east-1a"
}


variable "availability_zone_2" {
  type = string
  default = "us-east-1b"
}

variable "webserver_domain_zone" {
  type = string
  default = "f1kart.com."
}

variable "webserver_domain" {
  type = string
  default = "aws-meetup-cicd.f1kart.com"
}

variable "project" {
  type = string
  default = "cool_webapp"
}

#
# arguments for our cicd pipeline
#
variable "application_code_reponame" {
  type = string
  default = "cool_webapp"
}