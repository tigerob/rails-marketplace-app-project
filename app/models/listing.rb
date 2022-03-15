class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :listings_features, dependent: :destroy
  has_many :features, through: :listings_features

  enum condition: {brand_new: 1, used_excellent: 2, used_good: 3, used_ok: 4}

  has_one_attached :photo

  # data validations
  validates :title, presence: true, length: {maximum: 50}
  validates :price, presence: true, numericality: {only_integer: true}, length: {maximum: 9}
  validates :photo, :condition, presence: true
  validates :description, presence: true, length: {maximum: 750}
  validates :postcode, numericality: {only_integer: true}, length: {is: 4}
  validates :brand, length: {maximum: 50}
  validates :model, length: {maximum: 50}
  validates :finish, length: {maximum: 50}
  validates :capacity, length: {maximum: 4}
  validates :height, length: {maximum: 4}
  validates :width, length: {maximum: 4}
  validates :depth, length: {maximum: 4}
end