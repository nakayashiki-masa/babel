class Post < ApplicationRecord
  has_many :post_users
  has_many :users, through: :post_users
  has_many :reviews

  validates :title, presence: true
  validates :body, presence: true

  paginates_per 4
end
