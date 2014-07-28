# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@example.org" }

  factory :user do
    first_name 'John'
    last_name 'Doe'
    password 'password'
    password_confirmation 'password'
    mobile_phone '0883444555'
    email
  end
end
