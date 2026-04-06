FactoryBot.define do
  factory :review do
    user
    sequence(:gummy_name) { |n| "グミ#{n}" }
    sequence(:flavor) { |n| "フレーバー#{n}" }
    rating { 5 }
    sweetness { 3 }
    sourness { 3 }
    hardness { 3 }
    comment { 'とても美味しい。食感が最高でした!' }
  end
end
