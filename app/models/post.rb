class Post < ApplicationRecord
  has_rich_text :content
  has_one_attached :image
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: { minimum: 3 }
  validates :image, :content, presence: true
end
