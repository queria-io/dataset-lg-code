{# 政令指定都市のシートの区の行が、1枚目と同じ5列の並び（コード・都道府県名・市区町村名・
   都道府県名カナ・市区町村名カナ）で読めていることを確かめる。結果が0行なら成功。
   シートの列の並びが1枚目と違うと、都道府県名の列に区の名前が入るなどして、名前で照合する
   側（overturemaps の区画）が黙って1件も当たらなくなる。 #}

with code as (
    select * from {{ ref('mart_lg_code') }}
)

-- 区の行が1行も無い（シート名の不一致などで取り込めていない）
select null as lg_code, null as prefecture, null as city, 'no ward rows' as problem
where not exists (select 1 from code where code_type = 'ward')

union all

-- 都道府県名が、同じ都道府県コードの都道府県の行の名前と合わない
select ward.lg_code, ward.prefecture, ward.city, 'prefecture does not match pref_code' as problem
from code as ward
where ward.code_type = 'ward'
  and not exists (
      select 1 from code as pref
      where pref.code_type = 'prefecture'
        and pref.pref_code = ward.pref_code
        and pref.prefecture = ward.prefecture
  )

union all

-- 区の名前が、同じ都道府県の市の名前から始まっていない、またはカナが欠けている
select ward.lg_code, ward.prefecture, ward.city, 'ward name is not prefixed by its city' as problem
from code as ward
where ward.code_type = 'ward'
  and (
      ward.city_kana is null
      or ward.prefecture_kana is null
      or not exists (
          select 1 from code as city
          where city.code_type = 'municipality'
            and city.pref_code = ward.pref_code
            and city.city like '%市'
            and starts_with(ward.city, city.city)
            and length(ward.city) > length(city.city)
      )
  )
