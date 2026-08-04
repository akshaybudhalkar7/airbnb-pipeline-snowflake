terraform {
  required_version = ">= 1.11"

  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2.13"
    }
  }

  backend "s3" {
    bucket       = "airbnb-pipeline-tf-656559336744-us-east-1"
    key          = "snowflake/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "snowflake" {
  organization_name          = "XJVCLEX"
  account_name               = "NNC43628"
  user                       = "TF_SVC"
  role                       = "TF_DEPLOY"
  authenticator              = "WORKLOAD_IDENTITY"
  workload_identity_provider = "AWS"
}