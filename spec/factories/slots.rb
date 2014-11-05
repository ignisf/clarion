# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    starts_at { Time.now }
    ends_at { Time.now + 45.minutes }
    hall
  end
end
