# frozen_string_literal: true

FactoryBot.define do
  factory :chat do
    text { 'MyString' }
    user { nil }
    question { nil }
  end
end
