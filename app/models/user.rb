class User < ApplicationRecord
  has_many :post_users
  has_many :posts, through: :post_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
end
