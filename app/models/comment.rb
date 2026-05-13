# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :review

  validates :body, presence: true, length: { maximum: 1000 }
end
