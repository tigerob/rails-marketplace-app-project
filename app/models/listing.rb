class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :photo

  enum condition: {brand_new: 1, used_excellent: 2, used_good: 3, used_ok: 4}
end