# terrimap_de — State Master – Germany（仮）

ドイツ16州の「位置・州名・州都」を覚える地図クイズ。共通基盤 [`terrimap_core`](https://github.com/zka32101/terrimap_core)（地図・出題・進捗・デイリー）の上に載せたアプリ。

## 状態（v0.1 土台）
- ホーム: 16州の地図（正解済み=緑、ミス=赤）、称号、進捗バー
- クイズ（10問）: 地図タップ / 地図から州名 / 州名から州都 / 州都から州名 / 形当て
- デイリー（5問・日付固定・🟩🟥の共有文をコピー）
- 設定: 言語（英語・ドイツ語、端末言語で初期化）、データ出典の表示
- 進捗は端末に保存（`shared_preferences`）
- 課金・広告（`app_common_kit` v3.11.0）:
  - 無料は4州（16州の25%: バイエルン・ノルトライン＝ヴェストファーレン・バーデン＝ヴュルテンベルク・ベルリン）。残りは買い切り（`unlock_all_states`、権利 `premium`）で全州解放＋広告なし。サブスクなし
  - 無料の間のクイズは解放済みの4州だけを出題。デイリーは全員同じ問題のため、無料でも全州から出る
  - ロック中の州をタップすると解放の案内。設定に購入欄（キットの `PurchaseSection`）、購入の復元
  - 広告: ホームのバナー、クイズ・デイリー終了時の全画面広告（最短3分・1日5回、出題中は出さない）。同意（UMP/GDPR）はキットが処理。子ども向けにはしない
- `flutter analyze` クリーン、`flutter test` 13件通過（実機では未確認）

## 未実装・未決
- 課金・広告の**外部設定**（コードは実装済み。キーはコミットしない）:
  - RevenueCat: 公開SDKキーを `--dart-define=RC_PUBLIC_KEY=...` で渡す。Entitlement `premium` に、非消耗型の商品 `unlock_all_states` を紐づける。キーなしの開発ビルドは疑似購入のフェイクで動く
  - AdMob: 広告ユニットIDを `--dart-define=ADMOB_BANNER=... ADMOB_INTERSTITIAL=... ADMOB_REWARDED=...` で渡す。3つとも無いリリースビルドは広告なし（テストIDはリリースで使えない）
  - AdMob アプリID: `AndroidManifest.xml` と `Info.plist` は今は Google 公式のテストID。リリース前に本番IDへ差し替える
  - ストアの商品登録、iOS の ATT 文言（`NSUserTrackingUsageDescription` は英語の仮文）、価格（Tier）
- ドイツ語のキット文言は購入まわりだけ訳した（他は英語）
- アプリ名・bundle ID（現在は仮の `dev.terrimap.terrimap_de`）・価格・無料州の選定
- 都市州（ベルリン・ブレーメン・ハンブルク）の実機タップ確認
- ストア資料、アイコン、スプラッシュ

## データ
`packs/de` は `terrimap_core` が正本。更新は `tools/sync_pack.sh [コアのパス]`（検証つき）。
出典: Made with Natural Earth (naturalearthdata.com)（設定画面に表示）。

## アイコン
`assets/icon/app_icon.png`（1024×1024）は `terrimap_core` の `tools/make_icon.py de assets/icon/app_icon.png --td --label` で生成（塔・射程円・敵の進路と、左下の国旗色つき略称バッジ）（設計: `terrimap_core/docs/terrimap_icon_design_v0_1.md`）。Android・iOS のアイコンは `dart run flutter_launcher_icons` で作る。
- 色は仮。提出前にアイコン規定（安全領域など）とストア内での見分けやすさを確認する
- `flutter_launcher_icons` は `project.pbxproj` の `ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS` を `AppIcon` に書き換えるため、実行後はその差分を戻す（`YES` のまま）
