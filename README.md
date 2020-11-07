# Tiisana

普段の生活に取り入れるだけで環境に優しくそして未来にも繋がる、そんな情報が行き交う場所として制作した記事の投稿サイトです。



Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column        | Type     | Options     |
| ------------- | -------- | ----------- |
| nickname      | string   | null: false |
| email         | string   | null: false |
| password      | string   | null: false |
| profile       | text     | null: false |

### Association
- has_one_attached :image
- has_many :posts, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :like_posts, through: :likes, source: :post
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user

## Relationship テーブル

| Column                               | Type       | Options                       |
| ------------------------------------ | ---------- | ----------------------------- |
| user                                 | integer    | references                    |
| follow                               | integer    | references                    |
| [:user_id, :follow_id], unique: true | index      | foreign_key:{to_table: users} |

### Association
- belongs_to :user
- belongs_to :follow, class_name: 'User'

# comments テーブル

| Column  | Type        | Options                        |
| ------- | ----------- | ------------------------------ |
| text    | text        |                                |
| user    | references  | null: false, foreign_key: true |
| post    | references  | null: false, foreign_key: true |


## Association

- belongs_to :user
- belongs_to :posts

# posts テーブル

| Column      | Type             | Options                        |
| ----------- | ---------------- | ------------------------------ |
| title       | string           | null: false                    |
| user        | references       | null: false, foreign_key: true |
| likes_count | integer          |                                |


## Association
- has_rich_text :content
- has_one_attached :image
- belongs_to :user
- has_many :comments, dependent: :destroy
- has_many :tags, through: :post_tags
- has_many :likes, dependent: :destroy
- has_many :liking_users, through: :likes, source: :user

# likes テーブル

| Column    | Type        | Options                      |
| --------- | ----------- | ---------------------------- |
| user_id   | references  | foreign_key: true            |
| post_id   | references  | foreign_key: true            |

## Association
- belongs_to :post, counter_cache: :likes_count
- belongs_to :user
