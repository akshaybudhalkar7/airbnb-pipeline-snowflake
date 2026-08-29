{{ config(
    unique_key = 'host_id'
) }}

select * from {{ source('raw', 'hosts') }}

{% if is_incremental() %}
where _load_ts > (select max(_load_ts) from {{ this }})
{% endif %}

