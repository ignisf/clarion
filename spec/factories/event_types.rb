FactoryBot.define do
  factory :event_type do
    name { |n| "Track #{n}" }
    description { "MyText" }
    conference
    minimum_length { "45" }
    maximum_length { "60" }
  end
end
