FactoryBot.define do
  factory :task do
    user_email { "user@example.com" }
    user_id { "12345" }
    status { "pending" }
    created_at { Time.now }
    updated_at { Time.now }
    uuid { SecureRandom.uuid }
  end
end
