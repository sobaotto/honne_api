# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user

  has_many :answers

  validates :title, presence: true, length: { minimum: 5, maximum: 120, message: '5文字以上120字以下で入力してください' }
  validates :text, presence: true, length: { minimum: 5, maximum: 10_000, message: '5文字以上10000字以下で入力してください' }
  validates :is_public, inclusion: [true, false]

  default_scope -> { order(created_at: :desc) }
  scope :is_public, -> { where(is_public: true) }

  def own_question?(user)
    return false if user.nil?

    user_id == user.id
  end
end
