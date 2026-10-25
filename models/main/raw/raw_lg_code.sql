{{
    config(
        materialized='table'
    )
}}

{{ read_lg_code_xlsx(var('lg_code_xlsx_url')) }}
