#
# create out VPC
#
module "vpc" {
  source = "./vpc"

  availability_zones = [var.availability_zone_1, var.availability_zone_2]
  application_name = var.application_name
}

#
# create our load balanced ec2 webserver
#
module "ha_multi_instance" {
  source = "./webserver"

  providers = {
    aws = aws.north-america
  }

  # setup our instance
  ami_id = var.ami_id
  application_name = var.application_name

  # pass vpc details
  public_subnet1_id = module.vpc.public_subnet1_id
  public_subnet2_id = module.vpc.public_subnet2_id
  vpc_id = module.vpc.vpc_id

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

#
# create our slack notifications for a failed build
#

# our build event rule
data "template_file" "build_rule" {
  template = file("pipeline_event_rule.tpl")

  vars = {
    codepipeline_name = module.cicd_pipeline.codepipeline_name
    state = "FAILED"
  }
}

module "cicd_notification" {
  source = "./cicd_notification"


  message = "Build Failed, check your logs"
  application_name = "cool_webapp"
  rule = data.template_file.build_rule.rendered
  slack_url = var.slack_url
  subject = "cool webapp - build failed"
}