{{ config(
    unique_key= 'booking_id'
) }}

select * from {{ source('raw', 'bookings') }}

{% if is_incremental() %}
where _load_ts > (select max(_load_ts) from {{ this }})
{% endif %}