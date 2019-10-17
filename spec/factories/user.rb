FactoryBot.define do
  factory :user do
    email { 'austin@austin.com' }
    password { "whatever" }
    confirmed_at { Time.now }
  end
end
