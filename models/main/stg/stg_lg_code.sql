{{ config(materialized='view') }}

with code as (
    select *, case when city is null then 'prefecture' else 'municipality' end as code_type
    from {{ ref('raw_lg_code') }}
    union all
    select *, 'ward' as code_type
    from {{ ref('raw_lg_code_ward') }}
    where lg_code not in (select lg_code from {{ ref('raw_lg_code') }})
)

SELECT
    lg_code,
    SUBSTR(lg_code, 1, 2) AS pref_code,
    SUBSTR(lg_code, 1, 5) AS lg_code_5,
    prefecture,
    city,
    prefecture_kana,
    city_kana,
    code_type
FROM code
