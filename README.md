# アプリ名

## Tiisana

# 概要

環境に優しくそして未来にも繋がる、そんな情報が行き交う場所として制作した投稿サイトです。 
普段何気なく使っている消耗品、衣服や道具ももっと環境に配慮されなおかつオシャレで機能性も優れている製品が沢山あります。    
投稿はブログ形式で行い、ユーザー同士が交流もできるようにコメントやフォロー機能などもつけました。

アプリ名のTiisanaは、一人一人が作る日常の  "**小さな**"積み重ねが大きな未来を作る、という意味で名付けました。  

# 本番環境

https://tiisana.herokuapp.com/  

ログイン情報(テスト用)  

- Eメール :hogehoge@hoge
- パスワード :111111q


# 制作背景

一番大きな動機は自分自身が昔から自然が好きなことがありました。  
自然が好きだからこそ環境問題にもずっと興味はありましたし何か自分にもできることはないかと考えていました。  
しかしいざ少し調べてみると本格的すぎる活動や団体の記事ばかりでした。
サステナブルという言葉がかなり浸透し、それに伴うサービスも急激に増えていますが、そういった情報を消費者の立場から投稿しているようなサイトはありませんでした。    

なので今回のアプリのペルソナの設定は過去に自分が思った事を中心に  

- 最近環境についてよく言われるようになってきているのは分かるけど、具体的に自分に何ができるのか分からないと考えている。   
- 環境問題と聞くと少し身構えてしまうが、何か特別な活動をしないといけないのではないかと思っている。  
- すでにそういった商品やサービスを利用していて同じように興味を持つ人に向けて発信していきたいが、普通のSNSではすぐに他の情報に埋もれてしまう  
- 消費者目線で環境に繋がる有益な情報が集まるサイトがあればいいな。

という思いを持つ人の問題を解決するために今回のアプリを作成致しました。 

# DEMO
[![Image from Gyazo](https://i.gyazo.com/b1353626ae46d9a3dbfff1fa46dd2ae0.jpg)](https://gyazo.com/b1353626ae46d9a3dbfff1fa46dd2ae0)
<br>
<br>

## トップページ
![result-min (1)](https://user-images.githubusercontent.com/69751103/98460519-82788d80-21e8-11eb-914b-3116a1bb6f19.gif)
<br>
<br>

## 記事詳細画面
![result-min (3)](https://user-images.githubusercontent.com/69751103/98460725-257dd700-21ea-11eb-93b6-890e6c27356f.gif)
<br>
<br>
## 記事詳細画面からユーザーマイページへ
![result-min](https://user-images.githubusercontent.com/69751103/98460974-23b51300-21ec-11eb-903e-d6bfa97a5623.gif)
<br>
<br>

## タグ検索
![result-min (2)](https://user-images.githubusercontent.com/69751103/98461239-ef425680-21ed-11eb-820c-5d7d09607b62.gif)
<br>
<br>

# 工夫したポイント
- 環境の為にできることと一言で言ってもその内容は多岐に分かるので各ユーザーは投稿した記事に対して好きなタグを付けれるようにしました。
トップページには投稿されているタグの一覧を表示して、そのタグをクリックすると関連した記事が表示されるようになっています。  

- フォロー機能を実装し、自分がフォローしているユーザー、フォローされているユーザーをマイページからいつでも一覧表示させるようにしました。  

- いいね機能の実装をしたのですが、表示の部分をよくあるハートではなくて葉っぱにすることで少しでもアプリの個性が出るようにしてみました。  

- トップページにいいねされた回数の多い記事の上位３位までを人気の記事として表示しています。  

- 各ユーザーごとにプロフィールとアカウント画像の設定ができます。  


# 使用技術（開発環境）
## バックエンド
Ruby, Ruby on Rails  
## フロントエンド
Bootstrap4, JavaScript, Ajax
## データ・ベース
MySQL, Sequel Pro
## インフラ
Heroku
## ソース管理
GitHub, GitHubDesktop
## テスト
RSpec
## エディタ
VSCode

# 課題や今後実装したい機能
#### 今後実装したい機能
- インフラをHerokuからAWSに移行
- 環境構築にDockerを使用
- CircleCIを使用してデプロイの自動化
- カテゴリー機能
- 記事の下書きを保存できる機能  
- SNSとの連携  

# DB設計

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
