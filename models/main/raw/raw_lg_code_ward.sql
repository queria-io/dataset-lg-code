{# 政令指定都市のシート。市そのものの行（札幌市など）と区の行（札幌市中央区など）が並ぶ。
   市の行は1枚目にもあるので、stg で区の行だけを足す。シート名は URL と同じく基準日ごとに変わるので、
   dbt_project.yml の vars で URL と1組にしてある #}
{{
    config(
        materialized='table'
    )
}}

{{ read_lg_code_xlsx(var('lg_code_xlsx_url'), sheet=var('lg_code_ward_sheet')) }}
