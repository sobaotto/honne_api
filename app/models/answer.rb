# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :text, presence: true, length: { minimum: 5, maximum: 10_000, message: '5文字以上10000字以下で入力してください' }
  # exist_questionという命名迷った。もっといいものがありそう？
  validate :exist_question

  private

  def exist_question
    errors.add(:question_id, 'が見つかりません') if Question.find(question_id).nil?
  end
end
