# terrimap_ge — State Master – Germany（仮）

ドイツ16州の「位置・州名・州都」を覚える地図クイズ。共通基盤 [`terrimap_core`](https://github.com/zka32101/terrimap_core)（地図・出題・進捗・デイリー）の上に載せたアプリ。

## 状態（v0.1 土台）
- ホーム: 16州の地図（正解済み=緑、ミス=赤）、称号、進捗バー
- クイズ（10問）: 地図タップ / 地図から州名 / 州名から州都 / 州都から州名 / 形当て
- デイリー（5問・日付固定・🟩🟥の共有文をコピー）
- 設定: 言語（英語・ドイツ語、端末言語で初期化）、データ出典の表示
- 進捗は端末に保存（`shared_preferences`）
- `flutter analyze` クリーン、`flutter test` 5件通過（実機では未確認）

## 未実装・未決
- 課金・広告・同意（無料=最初の4〜5州+広告、買い切り=全州解放）。`app_common_kit` の再利用範囲を確認してから
- アプリ名・bundle ID（現在は仮の `dev.terrimap.terrimap_ge`）・価格・無料州の選定
- 都市州（ベルリン・ブレーメン・ハンブルク）の実機タップ確認
- ストア資料、アイコン、スプラッシュ

## データ
`packs/de` は `terrimap_core` が正本。更新は `tools/sync_pack.sh [コアのパス]`（検証つき）。
出典: Made with Natural Earth (naturalearthdata.com)（設定画面に表示）。
