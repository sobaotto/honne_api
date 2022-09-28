FactoryBot.define do
  factory :question do
    title { "初めての質問です" }
    text { "○○が××なのですが、なぜなんでしょうか？教えてください！" }
    is_public { false }
    user
  end
end
