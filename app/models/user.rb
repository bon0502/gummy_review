# frozen_string_literal: true

class User < ApplicationRecord
  enum role: { general: 0, admin: 20 }
  authenticates_with_sorcery!

  enum role: { general: 0, admin: 1 }

  mount_uploader :avatar, AvatarUploader

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :nickname, presence: true, length: { maximum: 255 }

  def own?(object)
    id == object.user_id
  end
end
