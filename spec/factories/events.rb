FactoryGirl.define do
  factory :event do
    title { |n| "Event #{n}" }
    length { 60 }
    abstract { 'foo' }
    description { 'foo' }
    conference
    language :bg
    after(:build) do |event, evaluator|
      evaluator.conference.tracks << create(:track)
      event.track = evaluator.conference.tracks.first

      evaluator.conference.event_types << create(:event_type)
      event.event_type = evaluator.conference.event_types.first
    end
  end
end
