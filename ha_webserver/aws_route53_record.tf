resource "aws_route53_record" "multiaz_instance" {
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  name    = var.webserver_domain
  type    = "A"

  alias {
    name                   = aws_lb.multi-instance-lb.dns_name
    zone_id                = aws_lb.multi-instance-lb.zone_id
    evaluate_target_health = true
  }
}