FactoryBot.define do
  factory :participation do
    association :participant, factory: :user
    event
    approved { false }
  end
end
