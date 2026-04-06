# frozen_string_literal: true

class FlavorGummy < ApplicationRecord
  belongs_to :flavor
  belongs_to :gummy
end
