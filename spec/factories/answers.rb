FactoryBot.define do
  factory :answer do
    text { "MyString" }
    user { nil }
    question { nil }
  end
end
