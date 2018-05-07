class Post < ApplicationRecord
  has_many :post_users
  has_many :users, through: :post_users

  validates :title, presence: true
  validates :body, presence: true

  paginates_per 4
end
