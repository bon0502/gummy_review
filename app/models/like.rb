# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :review, counter_cache: true

  validates :user_id, uniqueness: { scope: :review_id }
end
