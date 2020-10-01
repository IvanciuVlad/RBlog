class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :articles, dependent: :destroy
  has_many :article_categories
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_voter

  def self.search(param)
    param.strip!
    to_send_back = username_matches(param).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.username_matches(param)
    matches('username', param)
  end  

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  def except_current_user(users)
    users.reject {|user| user.id == self.id}
  end


  def not_friends_with?(if_of_friend)
    !self.friends.where(id: if_of_friend).exists?
  end
end
