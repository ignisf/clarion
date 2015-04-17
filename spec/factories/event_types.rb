FactoryGirl.define do
  factory :event_type do
    name { |n| "Track #{n}" }
    description 'MyText'
    conference
  end
end
