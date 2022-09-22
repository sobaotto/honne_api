FactoryBot.define do
  factory :question do
    title { "初めての質問です。" }
    text { "○○が××なのですが、なぜなんでしょうか？教えてください！" }
    public_flag { false }
    user
  end
end
