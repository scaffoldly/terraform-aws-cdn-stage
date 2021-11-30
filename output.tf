output "distribution_id" {
  value       = aws_cloudfront_distribution.distribution.id
  description = "The distribution ID"
}

output "service_slug" {
  value       = var.service_slug
  description = "Re-output of var.service_slug"
}

output "service_name" {
  value       = var.repository_name
  description = "Renamed output of var.repository_name"
}

output "stage" {
  value       = var.stage
  description = "Re-output of var.stage"
}

output "domain" {
  value       = "https://${var.certificate_arn != "" ? local.domain : aws_cloudfront_distribution.distribution.domain_name}"
  description = "Output of the domain or the cloudfront domain name, prefixed with https://"
}

output "origins" {
  value       = var.certificate_arn != "" ? [local.domain] : [aws_cloudfront_distribution.distribution.domain_name]
  description = "Output of the domain or the cloudfront domain name"
}
