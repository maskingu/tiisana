class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable

        has_one_attached :avatar
        has_many :posts, dependent: :destroy
        has_many :comments, dependent: :destroy
        has_many :likes, dependent: :destroy
        has_many :like_posts, through: :likes, source: :post

        

        with_options presence: true do
          validates :nickname, presence: true, length: { maximum: 10 }
          EMAIL_REGEX = /@+/.freeze
          validates :email, uniqueness: { case_sensitive: true }, format: { with: EMAIL_REGEX, message: '@を使用してください' }
          PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
          validates :password, confirmation: true, length: { minimum: 6 }, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' }
          
        end
        
end
