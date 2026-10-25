## データ出典

[総務省 全国地方公共団体コード](https://www.soumu.go.jp/denshijiti/code.html)が公開している市町村別コード（現行）です。全国の都道府県・市区町村等の団体コードと団体名（漢字・カナ）を収録しています。政令指定都市の区のコードも、同じファイルの「政令指定都市」シートから取り込んでいます。

## テーブル: mart_lg_code

団体コードをキーとした、都道府県・市区町村等のマスタです。

- lg_code: 団体コード（VARCHAR、JIS X0401/X0402 の6桁、チェックディジット付き）
- pref_code: 都道府県コード（VARCHAR、団体コードの先頭2桁）
- lg_code_5: 団体コード5桁（VARCHAR、チェックディジットを除いた先頭5桁）
- prefecture: 都道府県名（漢字、VARCHAR）
- city: 市区町村名（漢字、VARCHAR）。都道府県レコードでは NULL
- prefecture_kana: 都道府県名（半角カナ、VARCHAR）
- city_kana: 市区町村名（半角カナ、VARCHAR）。都道府県レコードでは NULL
- code_type: コード種別（VARCHAR、prefecture=都道府県、municipality=市区町村、ward=政令指定都市の区）

## ライセンス

[政府標準利用規約（第2.0版）](https://www.soumu.go.jp/menu_kyotsuu/policy/tyosaku.html)
