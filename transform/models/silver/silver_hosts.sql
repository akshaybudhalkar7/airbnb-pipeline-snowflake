{{

    config(
    materialized='incremental',
    unique_key='host_id'
    )

}}


SELECT 
HOST_ID,
REPLACE(HOST_NAME,' ','_') AS HOST_NAME 
HOST_SINCE,
IS_SUPERHOST,
RESPONSE_RATE,
CASE 
WHEN RESPONSE_RATE > 95 THEN 'Very Good'
WHEN RESPONSE_RATE > 85 THEN 'Good'
WHEN RESPONSE_RATE > 60 THEN 'FAIR'
ELSE 'POOR'
END AS RESPONSE_RATE_QUALITY,
CREATED_AT,
FROM 
{{ref('brz_hosts')}}
