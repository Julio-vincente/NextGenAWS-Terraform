data "aws_acm_certificate" "nextgenz_domain" {
  domain      = "nextgenz.click"
  statuses    = ["ISSUED"]
  most_recent = true
}
