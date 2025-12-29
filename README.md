# おうちノート（Ouchi Note）

マンション管理アプリ - 入居者情報・入金・修繕履歴などを一元管理

## 概要

| 項目 | 内容 |
|------|------|
| 目的 | 入居者情報・入金・修繕履歴などを一元管理 |
| 利用者 | オーナー、管理会社スタッフ |
| 技術 | Ruby on Rails / MySQL / Docker |

## ユーザー権限

| 権限 | できること |
|------|------------|
| オーナー | すべての閲覧・作成・編集・削除 |
| スタッフ | すべての閲覧のみ |

## 機能一覧

### 基本機能

| 機能 | 説明 |
|------|------|
| ユーザー管理 | オーナー/スタッフのログイン、権限管理 |
| 部屋管理 | 部屋番号、間取り、家賃などの基本情報 |
| 入居者管理 | 氏名、連絡先、入退去日、同居人数など |
| 駐車場管理 | 7台分の区画、使用者の管理 |
| 駐輪場管理 | 駐輪証番号と入居者の紐付け |
| バイク置き場管理 | 駐輪証番号と入居者の紐付け |
| 車両情報 | 車/バイクの種類、ナンバー |
| ペット管理 | 小型犬の有無 |
| 家賃入金管理 | 月ごとの入金状況、履歴一覧 |
| 修繕履歴管理 | 部屋ごとの修繕・メンテナンス記録 |
| 写真管理 | 入居時・退去時の写真（部屋ごと最大20枚程度） |

### 追加機能

| 機能 | 説明 |
|------|------|
| 契約管理 | 契約期間、保証人情報、契約書PDF保存 |
| 空室期間記録 | 部屋ごとの空室期間を自動計算・記録 |
| 家賃改定履歴 | 部屋の家賃変更履歴 |
| 滞納アラート | ダッシュボードで未入金・滞納者を強調表示 |
| 敷金・礼金記録 | 入居時の敷金・礼金、退去時の精算記録 |
| 収支サマリー | 月ごと・年ごとの収入と支出の集計 |
| クレーム・対応履歴 | 入居者ごとのトラブル対応記録 |
| メモ機能 | 入居者・部屋ごとの自由メモ |
| 検索・フィルター | 各種条件での絞り込み |

## 画面一覧

| 画面 | 説明 |
|------|------|
| ログイン | メールアドレス＋パスワード |
| ダッシュボード | 未入金者、滞納者、空室状況、収支サマリー概要 |
| 部屋一覧/詳細 | 部屋情報＋入居者＋修繕履歴＋写真＋家賃履歴＋空室期間 |
| 入居者一覧/詳細 | 入居者情報＋契約＋車両＋ペット＋入金履歴＋クレーム履歴＋メモ |
| 駐車場一覧 | 7台分の使用状況 |
| 駐輪場一覧 | 駐輪証ごとの割り当て状況 |
| 入金管理 | 月別の入金状況一覧、登録画面 |
| 収支サマリー | 月別・年別の収支レポート |
| 修繕履歴 | 部屋ごとの履歴一覧、登録画面 |
| ユーザー管理 | スタッフの追加・削除（オーナーのみ） |

## データベース設計

### users（ユーザー）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| email | string | メールアドレス |
| password_digest | string | パスワード |
| role | string | owner / staff |
| name | string | 名前 |

### rooms（部屋）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_number | string | 部屋番号 |
| floor_plan | string | 間取り |
| rent | integer | 現在の家賃 |
| status | string | 空室 / 入居中 |
| notes | text | 備考 |

### rent_histories（家賃改定履歴）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_id | bigint | 外部キー |
| rent | integer | 家賃 |
| started_on | date | 適用開始日 |
| notes | text | 備考 |

### room_vacancies（空室期間）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_id | bigint | 外部キー |
| vacant_from | date | 空室開始日 |
| vacant_until | date | 空室終了日（null=現在空室） |

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

### vehicles（車両）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| resident_id | bigint | 外部キー |
| vehicle_type | string | car / motorcycle |
| make_model | string | 車種 |
| plate_number | string | ナンバー |

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
| bicycle_count | integer | 自転車台数 |

### motorcycle_registrations（バイク置き場登録）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| resident_id | bigint | 外部キー |
| registration_number | string | 駐輪証番号 |

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

### room_photos（部屋写真）

| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint | 主キー |
| room_id | bigint | 外部キー |
| photo_type | string | move_in / move_out |
| taken_on | date | 撮影日 |

※ 画像は ActiveStorage を使用

### incidents（クレーム・対応履歴）

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

## 収支サマリーの計算ロジック

| 項目 | 計算方法 |
|------|----------|
| 収入 | payments（入金済み）の合計 |
| 支出 | maintenance_records（修繕費）の合計 |
| 利益 | 収入 − 支出 |