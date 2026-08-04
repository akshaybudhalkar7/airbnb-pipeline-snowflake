resource "snowflake_warehouse" "transform" {
  name           = "TRANSFORM_WH"
  warehouse_size = "XSMALL"
  auto_suspend   = 60
  auto_resume    = true
  comment        = "Managed by Terraform"
}

resource "snowflake_database" "raw" {
  name    = "RAW_DB"
  comment = "Managed by Terraform"
}