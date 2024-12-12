output "cloud_front_domain_name" {
  value = aws_cloudfront_distribution.ecs_cloudfront.domain_name
}

output "cloud_front_hosted_zone_id" {
  value = aws_cloudfront_distribution.ecs_cloudfront.hosted_zone_id
}
