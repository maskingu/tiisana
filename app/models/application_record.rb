class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  with_options presence: true do
    validates :nickname, presence: true, length: { maximum: 6 }
    EMAIL_REGEX = /@+/.freeze
    validates :email, uniqueness: { case_sensitive: true }, format: { with: EMAIL_REGEX, message: '@を使用してください' }
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    validates :password, confirmation: true, length: { minimum: 6 }, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両  方を含めて設定してください' }
    
  end
end
