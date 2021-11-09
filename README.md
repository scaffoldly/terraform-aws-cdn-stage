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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_s3_bucket.logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The bucket created for this CDN | `string` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the Certificate to use for the custom domain | `string` | n/a | yes |
| <a name="input_cloudfront_access_identity_path"></a> [cloudfront\_access\_identity\_path](#input\_cloudfront\_access\_identity\_path) | The CloudFront access identity used for the S3 bucket | `string` | n/a | yes |
| <a name="input_domains"></a> [domains](#input\_domains) | The list of domains to use with this CDN | `list(string)` | n/a | yes |
| <a name="input_logs_bucket_name"></a> [logs\_bucket\_name](#input\_logs\_bucket\_name) | The logs bucket | `string` | n/a | yes |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The repository name for this CDN | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The stage (e.g. nonlive, live) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | The distribution ID |
<!-- END_TF_DOCS -->
