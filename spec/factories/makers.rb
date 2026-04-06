FactoryBot.define do
  factory :maker do
    sequence(:name) { |n| "メーカー#{n}" }
  end
end
