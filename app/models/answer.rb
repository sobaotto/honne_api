# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :text, presence: true, length: { minimum: 5, maximum: 10_000, message: '5文字以上10000字以下で入力してください' }

  after_create :change_question_status

  private

  def change_question_status
    begin
      question_with_answer = Question.find_by!(id: question_id)
      question_with_answer.update!(question_status: 'resolved')
    rescue StandardError => e
      e
    end
  end
end
