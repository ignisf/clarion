FactoryGirl.define do
  factory :event do
    title { |n| "Event #{n}" }
    length { 60 }
    abstract { 'foo' }
    description { 'foo' }
  end
end
