# 全国地方公共団体コード

総務省が定める全国地方公共団体コード（6 桁）と、都道府県・市区町村・政令指定都市の区の名称（漢字・カナ）の対応を収録したデータセットです。市区町村コードを持つテーブルに名称を付けるときに結合します。

## 出典と利用条件

- [総務省「全国地方公共団体コード」](https://www.soumu.go.jp/denshijiti/code.html)の市町村別コード（現行）と、同じファイルの「政令指定都市」シートを加工して作成しています
- [政府標準利用規約（第2.0版）](https://www.soumu.go.jp/menu_kyotsuu/policy/tyosaku.html)に従います

## テーブル

`main.mart_lg_code` は 1 行が 1 団体です（都道府県 47、市区町村 1,747、政令指定都市の区 171）。

| 列 | 内容 |
| --- | --- |
| `lg_code` | 団体コード（JIS X0401/X0402 の 6 桁、チェックディジット付き） |
| `lg_code_5` | チェックディジットを除いた先頭 5 桁 |
| `pref_code` | 都道府県コード（先頭 2 桁） |
| `prefecture` / `prefecture_kana` | 都道府県名（漢字 / 半角カナ） |
| `city` / `city_kana` | 市区町村名（漢字 / 半角カナ）。都道府県の行は NULL |
| `code_type` | prefecture=都道府県、municipality=市区町村（東京の特別区を含む）、ward=政令指定都市の区 |

## 使い方

都道府県ごとに市区町村の数を出す:

```sql
SELECT prefecture, count(*) AS municipalities
FROM lg_code.main.mart_lg_code
WHERE code_type = 'municipality'
GROUP BY ALL
ORDER BY municipalities DESC;
```

## 注意

- 5 桁の市区町村コードを持つテーブルとは `lg_code_5` で結合してください
- 政令指定都市の区の `city` は「札幌市中央区」のように市の名前から書いています
- 現行のコードだけで、廃止された団体のコードは含みません
- 市区町村には北方領土の 6 村（色丹村など）を含みます。北海道の市区町村は 185 行です
