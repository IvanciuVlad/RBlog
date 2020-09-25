class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :description, presence: true, length: {minimum: 1, maximum: 255}
  validates :user_id, presence: true
  validates :article_id, presence: true
end
