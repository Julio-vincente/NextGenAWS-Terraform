output "domain_validation_options" {
  description = "acm domain validation options"
  value       = aws_acm_certificate.app_certificate.domain_validation_options
}

output "certificate_arn" {
  description = "certificate arn"
  value       = aws_acm_certificate.app_certificate.arn
}