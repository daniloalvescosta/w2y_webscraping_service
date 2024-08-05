FactoryBot.define do
  factory :task do
    user_email { "user@example.com" }
    status { "pending" }
    created_at { Time.now }
    updated_at { Time.now }
    uuid { SecureRandom.uuid }
  end
end
