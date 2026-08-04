terraform {
  required_version = ">= 2.13"

  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 1.0"
    }
  }

  backend "s3" {
    bucket       = "airbnb-pipeline-tf-656559336744-us-east-1 "
    key          = "snowflake/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "snowflake" {}