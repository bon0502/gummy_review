class Flavor < ApplicationRecord
  has_many :flavor_gummies, dependent: :destroy
  has_many :gummies, through: :flavor_gummies
end
