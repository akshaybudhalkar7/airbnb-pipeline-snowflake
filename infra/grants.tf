# --- dbt: needs compute, and write access to both databases ---

resource "snowflake_grant_privileges_to_account_role" "dbt_wh" {
  account_role_name = snowflake_account_role.dbt.name
  privileges        = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.transform.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_analytics_db" {
  account_role_name = snowflake_account_role.dbt.name
  privileges        = ["USAGE", "CREATE SCHEMA"]
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.analytics.name
  }
}

# dbt reads the raw layer as its source
resource "snowflake_grant_privileges_to_account_role" "dbt_raw_db" {
  account_role_name = snowflake_account_role.dbt.name
  privileges        = ["USAGE"]
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.raw.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_raw_schema" {
  account_role_name = snowflake_account_role.dbt.name
  privileges        = ["USAGE"]
  on_schema {
    schema_name = "\"RAW_DB\".\"LANDING\""
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_raw_tables" {
  account_role_name = snowflake_account_role.dbt.name
  privileges        = ["SELECT"]
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = "\"RAW_DB\".\"LANDING\""
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_raw_future_tables" {
  account_role_name = snowflake_account_role.dbt.name
  privileges        = ["SELECT"]
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = "\"RAW_DB\".\"LANDING\""
    }
  }
}

# --- loader: owns the raw layer ---

resource "snowflake_grant_privileges_to_account_role" "loader_raw_db" {
  account_role_name = snowflake_account_role.loader.name
  privileges        = ["USAGE", "CREATE SCHEMA"]
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.raw.name
  }
}

# --- analyst: reads marts, including ones that don't exist yet ---

resource "snowflake_grant_privileges_to_account_role" "analyst_db" {
  account_role_name = snowflake_account_role.analyst.name
  privileges        = ["USAGE"]
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.analytics.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analyst_future_schemas" {
  account_role_name = snowflake_account_role.analyst.name
  privileges        = ["USAGE"]
  on_schema {
    future_schemas_in_database = snowflake_database.analytics.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analyst_future_tables" {
  account_role_name = snowflake_account_role.analyst.name
  privileges        = ["SELECT"]
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.analytics.name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "analyst_future_views" {
  account_role_name = snowflake_account_role.analyst.name
  privileges        = ["SELECT"]
  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_database        = snowflake_database.analytics.name
    }
  }
}