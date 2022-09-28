class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :text, presence: true, length: { minimum: 5, maximum: 10000, message: '5文字以上10000字以下で入力してください' }
end
