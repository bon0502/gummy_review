class MainImage < ApplicationRecord
  belongs_to :review
  mount_uploader :image, PhotoUploader

  validates :image, presence: true
end
