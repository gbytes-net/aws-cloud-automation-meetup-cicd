#
# create our load balanced ec2 webserver
#
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
  project = var.project
  user_data_1 = "webserver_install_1.sh"

  # setup our domain
  webserver_domain = var.webserver_domain
  webserver_domain_zone = var.webserver_domain_zone
}

#
# create our cicd pipeline
#
module "cicd_pipeline" {
  source = "./cicd_pipeline"


  application_name = "cool_webapp"
  branch = "master"
  repository_name = var.application_code_reponame
}