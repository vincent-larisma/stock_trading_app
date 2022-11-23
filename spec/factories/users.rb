FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@test.com" }
    password {"email@test.com"}
    password_confirmation {"email@test.com"}
    role  { 0 }
    account_status  { 0 }
    confirmed_at    {Time.now}

  end
end
