[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/CHANGEME)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.0.4-blue.svg)

## Description

CHANGEME

## Usage

```hcl
module "CHANGME" {

}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.64.2 |
| <a name="provider_aws.dns"></a> [aws.dns](#provider\_aws.dns) | 3.64.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_s3_bucket.logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The bucket created for this CDN | `string` | n/a | yes |
| <a name="input_cdn_domains"></a> [cdn\_domains](#input\_cdn\_domains) | The list of CDN domains | `list(string)` | `[]` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the Certificate to use for the custom domain | `string` | `""` | no |
| <a name="input_cloudfront_access_identity_path"></a> [cloudfront\_access\_identity\_path](#input\_cloudfront\_access\_identity\_path) | The CloudFront access identity used for the S3 bucket | `string` | n/a | yes |
| <a name="input_logs_bucket_name"></a> [logs\_bucket\_name](#input\_logs\_bucket\_name) | The logs bucket | `string` | n/a | yes |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The repository name for this CDN | `string` | n/a | yes |
| <a name="input_root_domain"></a> [root\_domain](#input\_root\_domain) | The root domain | `string` | `""` | no |
| <a name="input_service_slug"></a> [service\_slug](#input\_service\_slug) | The shortened service slug for this CDN | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The stage (e.g. nonlive, live) | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The (optional) subdomain of var.root\_domain | `string` | `""` | no |
| <a name="input_subdomain_suffix"></a> [subdomain\_suffix](#input\_subdomain\_suffix) | Append a subdomain suffix | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | The distribution ID |
| <a name="output_domain"></a> [domain](#output\_domain) | Output of the domain or the cloudfront domain name, prefixed with https:// |
| <a name="output_origins"></a> [origins](#output\_origins) | Output of the domain or the cloudfront domain name |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | Renamed output of var.repository\_name |
| <a name="output_service_slug"></a> [service\_slug](#output\_service\_slug) | Re-output of var.service\_slug |
| <a name="output_stage"></a> [stage](#output\_stage) | Re-output of var.stage |
<!-- END_TF_DOCS -->
