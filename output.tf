output "distribution_id" {
  value       = aws_cloudfront_distribution.distribution.id
  description = "The distribution ID"
}

output "service_name" {
  value       = var.service_name
  description = "Re-output of var.service_name"
}

output "repository_name" {
  value       = var.repository_name
  description = "Re-output of var.repository_name"
}

output "stage" {
  value       = var.stage
  description = "Re-output of var.stage"
}

output "domain" {
  value       = "https://${length(var.domains) > 1 ? var.domains[0] : aws_cloudfront_distribution.distribution.domain_name}"
  description = "Output of var.domains[0], prefixed with https://"
}

output "origins" {
  value       = concat(var.domains, [aws_cloudfront_distribution.distribution.domain_name])
  description = "Combined list of var.domains and the cloudfront domain name"
}
