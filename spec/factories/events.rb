# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecture do
    title { |n| "Lecture #{n}" }
    subtitle "Lorem Ipsum"
    length 45
    language "bg_BG"
    abstract "An Abstract"
    description "A Description"
    notes "Some Notes"
    agreement true
    track
    user
  end

  factory :workshop do
    title { |n| "Workshop #{n}" }
    subtitle "Lorem Ipsum"
    length 60
    language "bg_BG"
    abstract "An Abstract"
    description "A Description"
    notes "Some Notes"
    agreement true
    track
    user
  end
end
