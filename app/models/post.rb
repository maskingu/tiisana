class Post < ApplicationRecord
  has_rich_text :content
  has_one_attached :image
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
    has_many :liking_users, through: :likes, source: :user


  validates :title, presence: true, length: { minimum: 3 }
  validates :image, :content, presence: true
  validates :content, presence: true


  scope :searchtext, -> (search_param = nil) {
    if search_param
        return if search_param.blank?
        joins("INNER JOIN action_text_rich_texts ON action_text_rich_texts.record_id = posts.id AND action_text_rich_texts.record_type = 'Post'")
      .where("action_text_rich_texts.body LIKE ? OR posts.title LIKE ? ", "%#{search_param}%", "%#{search_param}%")
    
      else
        all
      end
    }

end


