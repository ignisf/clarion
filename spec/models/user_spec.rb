require "rails_helper"

RSpec.describe User do
  it "lets Devise handle email and password validations" do
    expect(build(:user)).to be_a Devise::Models::Validatable
  end
end
