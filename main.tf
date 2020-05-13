module "vpc" {
  source = "./vpc"

  application_name = var.application_name

  availability_zones = [var.availability_zone_1, var.availability_zone_2]
}

