# アプリ名

## Tiisana

# 概要

環境に優しくそして未来にも繋がる、そんな情報が行き交う場所として制作した投稿サイトです。 
普段何気なく使っている消耗品、衣服や道具ももっと環境に配慮されなおかつオシャレで機能性も優れている製品が沢山あります。  
投稿はブログ形式で行い、ユーザー同士が交流もできるようにコメントやフォロー機能などもつけました。

サイトの名前にもなっているTiisanaは、一人一人が作る日常の小さな積み重ねが大きな未来を作る、という意味です。


# 制作背景

最近環境についてよく言われるようになってきているのはわかるけど、具体的に自分に何ができるのか分からない。  
そんな悩みを少しでも解決できる場にしたいと思い作りました。
環境保護と聞くと少し身構えてしまいますし、何か特別な活動をしないといけないのではないかと思いがちです。  
しかし今は世界的に環境保護に向けての動きが活発化しており、様々な商品やサービスが存在しています。 







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
