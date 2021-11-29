variable "service_slug" {
  type        = string
  description = "The shortened service slug for this CDN"
}

variable "repository_name" {
  type        = string
  description = "The repository name for this CDN"
}

variable "bucket_name" {
  type        = string
  description = "The bucket created for this CDN"
}

variable "logs_bucket_name" {
  type        = string
  description = "The logs bucket"
}

variable "stage" {
  type        = string
  description = "The stage (e.g. nonlive, live)"
}

variable "cloudfront_access_identity_path" {
  type        = string
  description = "The CloudFront access identity used for the S3 bucket"
}

variable "certificate_arn" {
  type        = string
  description = "The ARN of the Certificate to use for the custom domain"
  default     = ""
}

variable "root_domain" {
  type        = string
  description = "The root domain"
}

variable "domains" {
  type        = list(string)
  description = "The domains for this CDN"
  default     = []
}
