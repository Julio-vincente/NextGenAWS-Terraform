variable "domain_name" {
  type    = string
  default = "nextgenz.rf.gd"
}

variable "acm_name" {
  type    = string
  default = "app-certificate"
}

variable "domain_validation" {
  description = "domain_validation"
  type = string
}

variable "record_fqdn" {
  description = "record fqdn route53"
  type = string
}