{{ config(
    unique_key= 'listing_id'
) }}

select * from {{ source('raw', 'listings') }}

{% if is_incremental() %}
where _load_ts > (select max(_load_ts) from {{ this }})
{% endif %}