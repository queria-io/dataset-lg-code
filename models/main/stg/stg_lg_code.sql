{{ config(materialized='view') }}

with code as (
    select *, case when city is null then 'prefecture' else 'municipality' end as code_type
    from {{ ref('raw_lg_code') }}
    union all
    -- not in にしないのは、1枚目の lg_code に NULL が1つでもあると区の行が全部落ちるため
    select ward.*, 'ward' as code_type
    from {{ ref('raw_lg_code_ward') }} as ward
    where not exists (select 1 from {{ ref('raw_lg_code') }} as listed where listed.lg_code = ward.lg_code)
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
