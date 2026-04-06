# frozen_string_literal: true

class Maker < ApplicationRecord
  has_many :gummies, dependent: :destroy
end
