class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable

        has_one_attached :image
        has_many :posts, dependent: :destroy
        has_many :comments, dependent: :destroy
        has_many :likes, dependent: :destroy
        has_many :like_posts, through: :likes, source: :post

        has_many :relationships
        has_many :followings, through: :relationships, source: :follow
        has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
        has_many :followers, through: :reverse_of_relationships, source: :user
        
        
        validates :profile, length: { maximum: 200 }
        with_options presence: true do
          validates :nickname, presence: true, length: { maximum: 10 }
          EMAIL_REGEX = /@+/.freeze
          validates :email, uniqueness: { case_sensitive: true }, format: { with: EMAIL_REGEX, message: '@を使用してください' }
          PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
          validates :password, confirmation: true, length: { minimum: 6 }, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' }
        end

        def follow(other_user)
          unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)        
          end
        end

        def unfollow(other_user)
          relationship = self.relationships.find_by(follow_id: other_user.id)
          if relationship
            relationship.destroy
          end
        end

        def following?(other_user)
          self.followings.include?(other_user)
        end

        
end
