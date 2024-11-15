FactoryBot.define do
  factory :post do
    title { "My Post Title" }
    body { "This is the body of the post" }
    user
    state { false }
    category { :poetry }

    trait :with_state_true do
      state { true }
    end
  end
end
