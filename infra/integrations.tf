resource "snowflake_storage_integration" "s3_raw" {
  name                      = "S3_RAW_INT"
  type                      = "EXTERNAL_STAGE"
  storage_provider          = "S3"
  enabled                   = true
  storage_aws_role_arn      = "arn:aws:iam::656559336744:role/airbnb-pipeline-snowflake-s3-access"
  storage_allowed_locations = ["airbnb-pipeline-data-lake-656559336744-us-east-1/"]
  comment                   = "Managed by Terraform"
}