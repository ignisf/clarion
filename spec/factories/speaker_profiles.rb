# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :speaker_profile do
    first_name "John"
    last_name "Doe"
    organisation "Example Org"
    public_email "a@b.com"
    photo_url "http://placehold.it/50x50"
    mobile_phone "0883444555"
    biography "Lorem ipsum"
    github "octocat"
    twitter "handle"
    user
  end
end
