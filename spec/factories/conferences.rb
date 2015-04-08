# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference do
    title { |n| "Conference-#{n}" }
    email
    description 'MyText'
    start_date '2014-07-29 21:29:13'
    end_date '2014-07-31 21:29:13'

    factory :past_conference do
      start_date Date.today - 10.days
      end_date Date.today - 5.days
    end

    factory :future_conference do
      start_date Date.today + 5.days
      end_date Date.today + 10.days
    end
  end
end
