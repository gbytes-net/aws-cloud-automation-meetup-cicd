data "aws_route53_zone" "domain_zone" {
  name = var.webserver_domain_zone
}