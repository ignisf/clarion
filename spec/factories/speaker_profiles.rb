# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :speaker_profile do
    first_name "John"
    last_name "Doe"
    organisation "Example Org"
    public_email "a@b.com"
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'picture.jpg')) }
    mobile_phone "0883444555"
    biography "Lorem ipsum"
    github "octocat"
    twitter "handle"
    user
  end
end
