# アプリケーション名

WakWakWorks

# アプリケーション概要

施工管理者と作業員をマッチング するアプリです。施工管理者は、案件を投稿し、作業
内容・募集人数・報酬・作業日程を設定できます。作業員は案件を閲覧し、チャットを通
じて応募。施工管理者が承認するとマッチングが成立します。作業完了後はレビュー機能
で評価を記録。リアルタイムのチャット機能も搭載し、スムーズなやり取りが可能。短期
・単発の仕事探し にも最適な、建設業界向けのマッチングサービスです。

# URL

https://wakwak-works2.onrender.com/

# テスト用アカウント

ログイン機能等を実装した場合は、ログインに必要な情報を記載。 Basic 認証等を設け
ている場合は、その ID/Pass も記載すること。

# 利用方法

このアプリケーションの利用方法を記載。説明が長い場合は、箇条書きでリスト化するこ
と。

# アプリケーションを作成した背景

このアプリケーションを通じて、どのような人の、どのような課題を解決しようとしてい
るのかを記載。

# 実装した機能についての画像や GIF およびその説明

実装した機能について、それぞれどのような特徴があるのかを列挙する形で記載。画像は
Gyazo で、GIF は GyazoGIF で撮影すること。

# 実装予定の機能

洗い出した要件の中から、今後実装予定の機能がある場合は、その機能を記載。

# データベース設計

ER 図を添付。（ゆくゆく形になってきたら ER 図を完成させる。現状は以下の通り）

データベース設計 MVP **📌 テーブル一覧**

- **Users**（ユーザー管理機能）
- **JobPosts**（作業員募集機能）
- **JobApplications**（作業員の応募機能）
- **Reviews**（レビュー管理機能）
- **Chats**（案件ごとのチャット機能）
- **Messages**（メッセージ管理機能）

---

## **📌 Users テーブル（ユーザー）**

| Column        | Type   | Options     | 説明                                   |
| ------------- | ------ | ----------- | -------------------------------------- |
| role          | string | null: false | ユーザーの役割（施工管理者 or 作業員） |
| username      | string | null: false | ユーザー名                             |
| full_name     | string | null: false | 本名                                   |
| furigana      | string | null: false | ふりがな                               |
| birth_date    | date   | null: false | 生年月日                               |
| experience    | text   | null: false | 経験・スキル（簡易テキスト）           |
| qualification | string |             | 資格（例: 第二種電気工事士）           |
| address       | string |             | 住所（将来的に追加可能）               |
| phone_number  | string |             | 電話番号（将来的に追加可能）           |

✅ **アソシエーション**

- `has_many :job_posts, dependent: :destroy`（if role is '施工管理者'）
- `has_many :job_applications, dependent: :destroy`（if role is '作業員'）
- `has_many :received_reviews, class_name: 'Review', foreign_key: 'reviewee_id', dependent: :destroy`
- `has_many :given_reviews, class_name: 'Review', foreign_key: 'reviewer_id', dependent: :destroy`

---

## **📌 JobPosts テーブル（作業案件）**

| Column           | Type       | Options                        | 説明                           |
| ---------------- | ---------- | ------------------------------ | ------------------------------ |
| user_id          | references | null: false, foreign_key: true | 施工管理者（投稿者）の外部キー |
| work_title       | string     | null: false                    | 仕事のタイトル                 |
| work_description | text       | null: false                    | 仕事内容の説明                 |
| work_capacity    | integer    | null: false                    | 募集人数                       |
| work_start_date  | date       | null: false                    | 作業開始日                     |
| work_end_date    | date       | null: false                    | 作業終了日                     |
| work_payment     | integer    | null: false                    | 報酬（日本円）                 |
| work_location    | string     | null: false                    | 作業現場の住所                 |
| work_status      | string     | default: "recruiting"          | 募集状況（募集中 or 締め切り） |

✅ **アソシエーション**

- `belongs_to :user`
- `has_many :job_applications, dependent: :destroy`
- `has_many :chats, dependent: :destroy`

---

## **📌 JobApplications テーブル（応募管理）**

| Column      | Type       | Options                        | 説明                                 |
| ----------- | ---------- | ------------------------------ | ------------------------------------ |
| user_id     | references | null: false, foreign_key: true | 応募者の外部キー                     |
| job_post_id | references | null: false, foreign_key: true | 対象の作業案件の外部キー             |
| status      | string     | default: "pending"             | 応募ステータス（承認待ち・確定など） |

✅ **アソシエーション**

- `belongs_to :user`
- `belongs_to :job_post`

---

## **📌 Reviews テーブル（レビュー管理）**

| Column      | Type       | Options                        | 説明                      |
| ----------- | ---------- | ------------------------------ | ------------------------- |
| reviewer_id | references | null: false, foreign_key: true | 評価をしたユーザーの ID   |
| reviewee_id | references | null: false, foreign_key: true | 評価を受けたユーザーの ID |
| rating      | integer    | null: false                    | 評価スコア（1〜5）        |
| comment     | text       |                                | レビューコメント          |

✅ **アソシエーション**

- `belongs_to :reviewer, class_name: 'User'`
- `belongs_to :reviewee, class_name: 'User'`

---

## **📌 Chats & Messages テーブル（チャット管理）**

| Column      | Type       | Options                        | 説明            |
| ----------- | ---------- | ------------------------------ | --------------- |
| job_post_id | references | null: false, foreign_key: true | 作業案件の ID   |
| owner_id    | references | null: false, foreign_key: true | 施工管理者の ID |
| worker_id   | references | null: false, foreign_key: true | 作業員の ID     |

✅ **アソシエーション**

- `belongs_to :job_post`
- `belongs_to :owner, class_name: 'User'`
- `belongs_to :worker, class_name: 'User'`
- `has_many :messages, dependent: :destroy`

---

## **📌 Messages テーブル（メッセージ管理）**

| Column    | Type       | Options                        | 説明           |
| --------- | ---------- | ------------------------------ | -------------- |
| chat_id   | references | null: false, foreign_key: true | チャットの ID  |
| sender_id | references | null: false, foreign_key: true | 送信者の ID    |
| content   | text       | null: false                    | メッセージ内容 |
| read      | boolean    | default: false                 | 既読フラグ     |

✅ **アソシエーション**

- `belongs_to :chat`
- `belongs_to :sender, class_name: 'User'`

# 画面遷移図

画面遷移図を添付。

# 開発環境

使用した言語・サービスを記載。

# ローカルでの動作方法

`git clone` してから、ローカルで動作をさせるまでに必要なコマンドを記載。

# 工夫したポイント

制作背景使用技術

- Bootstrap を利用したデザイン
- Ajax を使うことで、ページ遷移なしに動的に更新可能にした

タスク管理

# 改善点

より改善するとしたらどこか、それはどのようにしてやるのか。

# 制作時間

アプリケーションを制作するのにかけた時間を記載。
