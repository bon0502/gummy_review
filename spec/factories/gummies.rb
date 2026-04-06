FactoryBot.define do
  factory :gummy do
    sequence(:name) { |n| "グミ#{n}" }
    association :maker
    photo_url { 'https://example.com/gummy.jpg' }  # photo ではなく photo_url
    overall_rating { 4.5 }
    sweetness { 3 }
    sourness { 2 }
    hardness { 4 }
    flavor { 'フルーツ味' }
  end
end
