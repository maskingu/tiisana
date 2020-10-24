# README

This README would normally document whatever steps are necessary to get the
application up and running.

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

### Association

- has_many :posts
- has_many :comments
- has_many :likes
- has_many :like_posts

# comments テーブル

| Column  | Type        | Options                        |
|  ------ |  ---------- |                                |
| text    | text        |                                |
| use     | references  | null: false, foreign_key: true |
| post    | references  | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :posts

# posts テーブル

| Column      | Type             | Options                        |
| ----------- | ---------------- | ------------------------------ |
| title       | string           |                                |
| user        | references       | null: false, foreign_key: true |
| likes_count | integer          |                                |


## Association

- belongs_to :user
- has_many :comments
- has_many :tags, through: :post_tags
- has_many :likes, dependent: :destroy
- has_many :liking_users, through: :likes, source: :user

# post-tags_relations テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| post   | references | foreign_key: true              |
| tag    | references | foreign_key: true              |

## Association

- belongs_to :post
- belongs_to :tag

# tags テーブル

| Column | Type    | Options                      |
| ------ | --------| ---------------------------- |
| name   | string  | null:false, uniqueness: true |

## Association

- has_many :posts, through: :post_tags

# likes テーブル

| Column    | Type        | Options                      |
| --------- | ----------- | ---------------------------- |
| user_id   | references  | foreign_key: true            |
| post_id   | references  | foreign_key: true            |

## Association
- belongs_to :post, counter_cache: :likes_count
- belongs_to :user