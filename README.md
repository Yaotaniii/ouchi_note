# おうちノート（Ouchi Note）

マンション管理アプリ - 入居者情報・入金・修繕履歴などを一元管理

## 概要

| 項目 | 内容 |
|------|------|
| 目的 | 入居者情報・入金・修繕履歴などを一元管理 |
| 利用者 | オーナー、管理会社スタッフ |
| 技術 | Ruby on Rails 7 / MySQL / Docker |

## セットアップ

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

# 初期データを投入（駐車場など）
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
| オーナー | すべての閲覧・作成・編集・削除 |
| スタッフ | すべての閲覧のみ |

## 機能一覧

### 基本機能

| 機能 | 説明 | 状態 |
|------|------|------|
| ユーザー認証 | オーナー/スタッフのログイン、権限管理 | ✅ 完成 |
| ダッシュボード | 入居状況、滞納アラート、未解決対応など一覧 | ✅ 完成 |
| 部屋管理 | 部屋番号、間取り、家賃などの基本情報 | ✅ 完成 |
| 入居者管理 | 氏名、連絡先、入退去日、同居人数など | ✅ 完成 |
| 契約管理 | 契約期間、保証人情報、敷金・礼金 | ✅ 完成 |
| 入金管理 | 月ごとの入金状況、履歴一覧 | ✅ 完成 |
| 修繕履歴管理 | 部屋ごとの修繕・メンテナンス記録 | ✅ 完成 |
| 駐車場管理 | 区画の使用状況（オーナー/入居者） | ✅ 完成 |
| 駐輪場管理 | 駐輪証番号と入居者の紐付け | ✅ 完成 |
| バイク置き場管理 | 駐輪証番号と入居者の紐付け | ✅ 完成 |
| 車両情報 | 車/バイクの種類、ナンバー | ✅ 完成 |
| 対応履歴 | クレーム・トラブルの対応記録 | ✅ 完成 |
| 家賃改定履歴 | 部屋の家賃変更履歴 | ✅ 完成 |
| 部屋写真管理 | 入居時・退去時の写真（モーダル拡大表示） | ✅ 完成 |
| 使い方ガイド | アプリの使い方ヘルプページ | ✅ 完成 |

### 未実装

| 機能 | 説明 |
|------|------|
| 空室期間記録 | 部屋ごとの空室期間を自動計算・記録 |
| 収支サマリー | 月ごと・年ごとの収入と支出の集計 |

## 画面一覧

| 画面 | 説明 |
|------|------|
| ログイン | メールアドレス＋パスワード |
| ダッシュボード | 入居状況、滞納アラート、未解決対応、駐車場状況など |
| 部屋一覧/詳細 | 部屋情報＋家賃改定履歴＋写真 |
| 入居者一覧/詳細 | 入居者情報＋契約情報 |
| 入金管理 | 月別の入金状況一覧、登録画面 |
| 修繕履歴 | 部屋ごとの履歴一覧、登録画面 |
| 駐車場一覧 | 区画の使用状況 |
| 駐輪場一覧 | 駐輪証ごとの割り当て状況 |
| バイク置場一覧 | 駐輪証ごとの割り当て状況 |
| 車両一覧 | 車・バイクの情報 |
| 対応履歴一覧/詳細 | クレーム・トラブルの記録 |
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
| rent | integer | 現在の家賃 |
| status | string | vacant / occupied |
| notes | text | 備考 |

### residents（入居者）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_id | bigint | 外部キー |
| name | string | 氏名 |
| phone | string | 電話番号 |
| email | string | メールアドレス |
| emergency_contact | string | 緊急連絡先 |
| move_in_date | date | 入居日 |
| move_out_date | date | 退去日 |
| has_pet | boolean | ペット有無 |
| pet_details | string | ペット詳細 |
| occupants_count | integer | 同居人数 |
| notes | text | 備考 |

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

### maintenance_records（修繕履歴）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_id | bigint | 外部キー |
| title | string | タイトル |
| description | text | 詳細 |
| performed_on | date | 実施日 |
| cost | integer | 費用 |

### rent_histories（家賃改定履歴）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_id | bigint | 外部キー |
| rent | integer | 家賃 |
| started_on | date | 適用開始日 |
| notes | text | 備考 |

### room_photos（部屋写真）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_id | bigint | 外部キー |
| photo_type | string | move_in / move_out |
| taken_on | date | 撮影日 |

※ 画像は Active Storage を使用

### parking_spaces（駐車場）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| space_number | string | 区画番号 |
| user_type | string | resident / owner |
| resident_id | bigint | 外部キー（nullable） |
| notes | text | 備考 |

### bicycle_registrations（駐輪場登録）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| resident_id | bigint | 外部キー |
| registration_number | string | 駐輪証番号 |

### motorcycle_registrations（バイク置き場登録）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| resident_id | bigint | 外部キー |
| registration_number | string | 駐輪証番号 |

### vehicles（車両）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| resident_id | bigint | 外部キー |
| vehicle_type | string | car / motorcycle |
| make_model | string | 車種 |
| plate_number | string | ナンバー |

### incidents（対応履歴）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| resident_id | bigint | 外部キー |
| room_id | bigint | 外部キー（nullable） |
| incident_type | string | complaint / trouble / inquiry / other |
| title | string | タイトル |
| description | text | 詳細 |
| occurred_on | date | 発生日 |
| resolved_on | date | 解決日（nullable） |
| status | string | open / resolved |