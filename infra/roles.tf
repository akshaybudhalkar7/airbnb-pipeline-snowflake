resource "snowflake_account_role" "loader" {
  name    = "LOADER"
  comment = "Writes to RAW_DB"
}

resource "snowflake_account_role" "dbt" {
  name    = "DBT_ROLE"
  comment = "Builds analytics models"
}

resource "snowflake_account_role" "analyst" {
  name    = "ANALYST"
  comment = "Reads marts"
}

resource "snowflake_grant_account_role" "loader_to_sysadmin" {
  role_name        = snowflake_account_role.loader.name
  parent_role_name = "SYSADMIN"
}

resource "snowflake_grant_account_role" "dbt_to_sysadmin" {
  role_name        = snowflake_account_role.dbt.name
  parent_role_name = "SYSADMIN"
}

resource "snowflake_grant_account_role" "analyst_to_sysadmin" {
  role_name        = snowflake_account_role.analyst.name
  parent_role_name = "SYSADMIN"
}