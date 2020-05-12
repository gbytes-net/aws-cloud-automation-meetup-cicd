variable "availability_zones" {
  type = list(string)

  description = "the availability zone names for the region"
}

variable "application_name" {
  type = string
  description = "The name of the project using this module"
}