variable "domain_name" {
  type    = string
  default = "nextgenz.rf.gd"
}

variable "zone_name" {
  type    = string
  default = "www"
}

variable "alb_dns_name" {
  description = "alb dns name"
  type        = string
}

variable "alb_zone_id" {
  description = "alb zone id"
  type        = string
}

variable "certificate_arn" {
  description = "certificate arn"
  type        = string
}

variable "domain_validation_options" {
  type = list(object({
    domain_name           = string
    resource_record_name  = string
    resource_record_type  = string
    resource_record_value = string
  }))
}
