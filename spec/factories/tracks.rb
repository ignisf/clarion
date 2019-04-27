# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :track do
    name { |n| "Track#{n}" }
    color { '#000000' }
    description { 'Some description' }
    conference
  end
end
