module "ha_multi_instance" {
  source = "./ha_webserver"

  providers = {
    aws = aws.north-america
  }

  # seutp our instances
  ami_id = var.ami_id
  availability_zones = [
    var.availability_zone_1,
    var.availability_zone_2]
  project = "meetup_cicd"
  user_data_1 = "webserver_install_1.sh"

  # setup our domain
  webserver_domain = var.webserver_domain
  webserver_domain_zone = var.webserver_domain_zone
}