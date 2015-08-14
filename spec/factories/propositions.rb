FactoryGirl.define do
  factory :proposition do
    association :proposer, factory: :user
    association :proposable, factory: :event
  end
end
