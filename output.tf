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
  value       = "https://${length(var.domains) > 1 ? var.domains[0] : aws_cloudfront_distribution.distribution.domain_name}"
  description = "Output of var.domains[0] or the cloudfront domain name, prefixed with https://"
}

output "origins" {
  value       = length(var.domains) > 0 ? var.domains : [aws_cloudfront_distribution.distribution.domain_name]
  description = "Combined list of var.domains and the cloudfront domain name"
}
