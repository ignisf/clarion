# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  sequence(:email) { |n| "user-#{n}@example.org" }

  factory :user do
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now - 15.minutes }
    email

    factory :administrator do
      admin { true }
    end
  end
end
