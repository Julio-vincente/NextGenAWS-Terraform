resource "aws_route53_zone" "main" {
  name = "cloudjuliolab.click"
}

resource "aws_route53_record" "alb_route" {
  zone_id = aws_route53_zone.main.id
  name = "cloudjuliolab.click"
  type = "A"

  alias {
    name = var.alb_dns_name
    zone_id = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
    zone_id = aws_route53_zone.main.id
    name = "www"
    type = "CNAME"
    ttl = 5
}