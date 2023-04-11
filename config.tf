terraform {
  required_version = ">= 1.0, < 1.5"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.dns]
    }
  }
}

provider "aws" {
  alias = "dns"
}