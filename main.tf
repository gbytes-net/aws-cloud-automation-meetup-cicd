module "vpc" {
  source = "./vpc"

  application_name = var.application_name

  availability_zones = [var.availability_zone_1, var.availability_zone_2]
}

module "webserver" {
  source = "./webserver"

  # instance details
  ami_id = var.ami_id
  application_name = var.application_name

  #
  public_subnet1_id = module.vpc.public_subnet1_id
  public_subnet2_id = module.vpc.public_subnet2_id
  vpc_id = module.vpc.vpc_id

  # DNS
  webserver_domain = var.webserver_domain
  webserver_domain_zone = var.webserver_domain_zone
}