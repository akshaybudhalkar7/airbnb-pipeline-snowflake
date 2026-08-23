{{ config(
    unique_key = 'hosts_id'
) }}

select * from {{source('raw','hosts')}}

{% if is_incremental() %}
where _load_ts > select max(load_ts) from {{ this }}
{% endif %}

