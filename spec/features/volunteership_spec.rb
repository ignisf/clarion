require "rails_helper"

feature "Volunteering" do
  before do
    Rails.application.load_seed
    sign_in_as_admin
    create_new_conference
    sign_out
  end

  scenario "A user applies to be a volunteer for the upcoming conference" do
    visit root_path
    click_on I18n.t("views.volunteers.apply")

    fill_in_volunteer_profile
    expect(page).to have_content I18n.t("views.volunteers.successful_application")

    sign_in_as_admin
    click_on_first_conference_in_management_root
    click_on I18n.t("activerecord.models.volunteership", count: 2).capitalize
    expect(page).to have_content "Volunteer Foo"
  end
end
