FactoryBot.define do
  factory :personal_profile do
    first_name { 'Foo' }
    last_name { 'Bar' }
    organisation { 'foo inc.' }
    public_email { 'foo@example.com' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'picture.jpg')) }
    mobile_phone { '+359883444555' }
    biography { 'Just a bio' }
    github { 'foobar' }
    twitter { 'foobar' }
    user
    conference
  end
end
