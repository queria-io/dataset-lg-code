{# 総務省 全国地方公共団体コード（市町村別コード・現行）
   https://www.soumu.go.jp/denshijiti/code.html
   xlsx 5列。1行目はヘッダー（改行入りの日本語名）のため range で読み飛ばし、位置（A〜E）で取得する。
   sheet を省くと1枚目（現在の団体）を読む。1枚目のシート名には基準日（例: R6.1.1現在の団体）が
   含まれ更新ごとに変わるため指定しない。2枚目（政令指定都市）は名前でしか選べないので、
   URL と一緒に呼び出し側で渡す #}
{% macro read_lg_code_xlsx(url, sheet=none) %}
select
    "A" as lg_code,
    "B" as prefecture,
    "C" as city,
    "D" as prefecture_kana,
    "E" as city_kana
from read_xlsx(
    '{{ url }}',
    {% if sheet %}sheet = '{{ sheet }}',{% endif %}
    header = false,
    range = 'A2:E1048576',
    all_varchar = true,
    stop_at_empty = true
)
{% endmacro %}
