class Post < ApplicationRecord
  has_rich_text :content
  has_one_attached :image

  validates :title, presence: true, length: { minimum: 5 }
  validates :image, :content, presence: true
end
