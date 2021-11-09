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
  value       = "https://${var.domains[0]}"
  description = "Output of var.domains[0], prefixed with https://"
}

output "origins" {
  value       = var.domains
  description = "Re-output of var.domains"
}
