{# 政令指定都市のシート。市そのものの行（札幌市など）と区の行（札幌市中央区など）が並ぶ。
   市の行は1枚目にもあるので、stg で区の行だけを足す。シート名は URL と同じく基準日ごとに変わる #}
{{
    config(
        materialized='table'
    )
}}

{{ read_lg_code_xlsx(
    'https://www.soumu.go.jp/main_content/000925835.xlsx',
    sheet='R6.1.1政令指定都市'
) }}
