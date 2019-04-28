require "rails_helper"

feature "Landing page" do
  before do
    Rails.application.load_seed
    sign_in_as_admin
    create_new_conference
    sign_out
  end

  it "displays information about the conference" do
    visit root_path
    expect(page).to have_content I18n.t(:home_title, conference: "FooConf #{1.year.from_now.year}")
  end
end
