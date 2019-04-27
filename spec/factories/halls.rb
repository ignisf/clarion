# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :hall do
    name { |n| "Hall#{n}" }
    conference
  end
end
