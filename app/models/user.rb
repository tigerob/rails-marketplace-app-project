class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings
  has_many :bought_purchases, foreign_key: "buyer_id", class_name: "Purchase"
  has_many :sold_purchases, foreign_key: "seller_id", class_name: "Purchase"
end
