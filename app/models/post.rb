class Post < ApplicationRecord
  has_rich_text :content
  has_one_attached :image
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3 }
  validates :image, :content, presence: true
end
