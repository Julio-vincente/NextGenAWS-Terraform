resource "aws_acm_certificate" "app_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]

  tags = {
    Name = var.acm_name
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn        = aws_acm_certificate.app_certificate.arn
  validation_record_fqdns = [var.record_fqdn]
}