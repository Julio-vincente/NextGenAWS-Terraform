resource "aws_route53_zone" "nextgen_hosted_zone" {
  name = "nextgenz.click"
}

resource "aws_route53_record" "www_record" {
  zone_id = aws_route53_zone.nextgen_hosted_zone.zone_id
  name    = "www.nextgenz.click"
  type    = "CNAME"
  ttl     = 300
  records = ["nextgenz.click"]
}

resource "aws_route53_record" "alb_record" {
  zone_id = aws_route53_zone.nextgen_hosted_zone.zone_id
  name    = "nextgenz.click"
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id 
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "CertificateManagerRecord" {
  zone_id = aws_route53_zone.nextgen_hosted_zone.zone_id
  name    = "_1d3e6eae8084f86ff591a98d2a51971b.nextgenz.click."
  type    = "CNAME"
  ttl     = 300
  records = ["_01969d5adff885c86ddb9339d6df845d.zfyfvmchrl.acm-validations.aws."]
}
