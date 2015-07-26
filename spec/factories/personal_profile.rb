FactoryGirl.define do
  factory :personal_profile do
    association :user

    first_name "Some"
    last_name "Person"
    picture File.open(Rails.root.join("spec/support/picture.jpg"))
    mobile_phone "0883 123 456"
    biography "Biography"
    sequence(:public_email) { |n| "email#{n}@example.com" }
    twitter "example"
    github "example"
  end
end
