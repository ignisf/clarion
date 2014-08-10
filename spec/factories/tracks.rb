# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    name { |n| "Track#{n}" }
    color '#000000'
    conference
  end
end
