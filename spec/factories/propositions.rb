FactoryGirl.define do
  factory :proposition do
    association :proposer, factory: :user
    association :proposition_accepting, factory: :track
    association :proposable, factory: :event
  end
end
