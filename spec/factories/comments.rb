FactoryBot.define do
  factory :comment do
    body { "This is a comment body" }
    association :post
    association :user
  end
end
