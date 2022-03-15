class Feature < ApplicationRecord
    has_many :listings_features
    has_many :listings, through: :listings_features
end
