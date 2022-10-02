# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    text { '新規の回答です。参考にしてください。' }
    user
    question
  end
end
