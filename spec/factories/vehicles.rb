FactoryBot.define do
  factory :vehicle do
    model { "Example Model" }
    brand { "Example Brand" }
    price { 19999.99 }
    created_at { Time.now }
    updated_at { Time.now }
    association :task
  end
end
