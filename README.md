# おうちノート

マンション管理アプリ - 入居者情報・入金・修繕履歴などを一元管理

## 概要

| 項目 | 内容 |
|------|------|
| 目的 | 入居者情報・入金・修繕履歴などを一元管理 |
| 利用者 | オーナー、管理会社スタッフ |
| 技術 | Ruby on Rails 7 / PostgreSQL / Docker |
| 本番環境 | Render（Web + DB） |
| 画像保存 | Cloudinary |

## セットアップ（ローカル開発）

### 必要な環境

- Docker
- Docker Compose

### 起動方法
```bash
# リポジトリをクローン
git clone https://github.com/your-username/ouchi_note.git
cd ouchi_note

# Docker イメージをビルド
docker compose build

# データベースを作成
docker compose run --rm web rails db:create db:migrate

# 初期データを投入
docker compose run --rm web rails db:seed

# サーバーを起動
docker compose up
```

ブラウザで http://localhost:3000 にアクセス

### テストユーザー

| 役割 | Email | Password |
|------|-------|----------|
| オーナー | owner@example.com | password123 |

## ユーザー権限

| 権限 | できること |
|------|------------|
| オーナー | すべての閲覧・作成・編集・削除、ユーザー管理 |
| スタッフ | すべての閲覧のみ |

## 機能一覧

### 基本機能

| 機能 | 説明 |
|------|------|
| ユーザー認証 | オーナー/スタッフのログイン、権限管理 |
| ダッシュボード | 入居状況、滞納アラート、未解決対応、操作履歴など一覧 |
| 部屋管理 | 部屋番号、間取り、家賃、共益費などの基本情報 |
| 入居者管理 | 氏名、ふりがな、連絡先、緊急連絡先（続柄）、同居人リスト |
| 契約管理 | 契約期間、保証人情報、敷金・礼金 |
| 入金管理 | 月ごとの入金状況、入居者登録時に自動作成 |
| 修繕履歴管理 | 部屋ごとの修繕・メンテナンス記録 |
| 駐車場管理 | 区画の使用状況（オーナー/入居者）、視覚的マップ表示 |
| 駐輪場管理 | 駐輪証番号と入居者の紐付け |
| バイク置場管理 | 駐輪証番号と入居者の紐付け |
| 車両情報 | 車/バイクの種類、ナンバー |
| 対応履歴 | クレーム・トラブルの対応記録 |
| 家賃改定履歴 | 部屋の家賃変更履歴 |
| 部屋写真管理 | 入居時・退去時の写真（Cloudinaryで保存） |
| 駐車代・駐輪代 | 入居者ごとの駐車代・駐輪代・バイク置場代 |
| 操作履歴 | 誰がいつ何を変更したかを自動記録 |
| ユーザー管理 | オーナーによるユーザーの作成・編集・削除 |
| 使い方ガイド | アプリの使い方ヘルプページ |
| スマホ対応 | レスポンシブデザイン、ハンバーガーメニュー |

## 画面一覧

| 画面 | 説明 |
|------|------|
| ログイン | メールアドレス＋パスワード |
| ダッシュボード | 入居状況、滞納アラート、未解決対応、操作履歴など |
| 部屋一覧/詳細 | 部屋情報＋家賃改定履歴＋写真 |
| 入居者一覧/詳細 | 入居者情報＋契約情報＋同居人リスト＋月額合計 |
| 入金管理 | 月別の入金状況一覧、登録画面 |
| 修繕履歴 | 部屋ごとの履歴一覧、登録画面 |
| 駐車場一覧 | 区画の使用状況（マップ表示） |
| 駐輪場一覧 | 駐輪証ごとの割り当て状況 |
| バイク置場一覧 | 駐輪証ごとの割り当て状況 |
| 車両一覧 | 車・バイクの情報 |
| 対応履歴一覧/詳細 | クレーム・トラブルの記録 |
| ユーザー管理 | ユーザーの一覧・作成・編集・削除（オーナーのみ） |
| 使い方ガイド | アプリの使い方 |

## データベース設計

### users（ユーザー）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| email | string | メールアドレス |
| encrypted_password | string | パスワード（暗号化） |
| role | string | owner / staff |
| name | string | 名前 |

### rooms（部屋）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_number | string | 部屋番号 |
| floor_plan | string | 間取り |
| rent | integer | 家賃 |
| management_fee | integer | 共益費 |
| status | string | vacant / occupied |
| notes | text | 備考 |

### residents（入居者）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_id | bigint | 外部キー |
| name | string | 氏名 |
| name_furigana | string | ふりがな |
| phone | string | 電話番号 |
| email | string | メールアドレス |
| emergency_contact | string | 緊急連絡先 |
| emergency_contact_relation | string | 緊急連絡先（続柄） |
| move_in_date | date | 入居日 |
| move_out_date | date | 退去日 |
| has_pet | boolean | ペット有無 |
| pet_details | string | ペット詳細 |
| occupants_count | integer | 同居人数 |
| parking_fee | integer | 駐車代 |
| bicycle_fee | integer | 駐輪代 |
| motorcycle_fee | integer | バイク置場代 |
| notes | text | 備考 |

### occupants（同居人）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| resident_id | bigint | 外部キー |
| name | string | 氏名 |
| name_furigana | string | ふりがな |
| relation | string | 続柄 |

### contracts（契約情報）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| resident_id | bigint | 外部キー |
| start_date | date | 契約開始日 |
| end_date | date | 契約終了日 |
| guarantor_name | string | 保証人名 |
| guarantor_phone | string | 保証人電話番号 |
| guarantor_address | string | 保証人住所 |
| deposit | integer | 敷金 |
| key_money | integer | 礼金 |
| deposit_returned | integer | 退去時返金額 |
| notes | text | 備考 |

### payments（入金記録）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| resident_id | bigint | 外部キー |
| year_month | string | 対象年月（例：2024-01） |
| amount | integer | 金額 |
| paid_on | date | 入金日 |
| status | string | paid / unpaid |
| notes | text | 備考 |

### activity_logs（操作履歴）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| user_id | bigint | 外部キー |
| action | string | create / update / destroy |
| target_type | string | 対象種別（部屋、入居者など） |
| target_name | string | 対象名 |
| details | text | 詳細 |

## 本番環境（Render）

### デプロイ

GitHubにプッシュすると自動デプロイされます。

### 環境変数（Render）

| 変数名 | 説明 |
|--------|------|
| DATABASE_URL | PostgreSQL接続URL |
| RAILS_ENV | production |
| RAILS_MASTER_KEY | config/master.keyの内容 |
| CLOUDINARY_CLOUD_NAME | Cloudinaryのクラウド名 |
| CLOUDINARY_API_KEY | CloudinaryのAPIキー |
| CLOUDINARY_API_SECRET | CloudinaryのAPIシークレット |

## テスト
```bash
docker compose run --rm web rails test test/models/
```