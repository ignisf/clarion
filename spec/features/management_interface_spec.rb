require "rails_helper"

feature 'Conference management' do
  before do
    Rails.application.load_seed
  end

  scenario 'Creating a new conference' do
    sign_in_as_admin
    visit management_root_path
    expect(page).to_not have_content "FooConf #{1.year.from_now.year}"
    create_new_conference
    visit management_root_path
    expect(page).to have_content "FooConf #{1.year.from_now.year}"
  end

  scenario 'Enabling the call for papers of a conference' do
    sign_in_as_admin
    create_new_conference
    visit root_path
    expect(page).to have_link I18n.t('views.welcome.submit_event', event_type: '')
    visit management_root_path
    click_on I18n.t('actions.view.button', model: Conference.model_name.human), match: :first
    click_on I18n.t('management.conferences.show.cfp_status')
    expect(page).to_not have_link I18n.t('views.welcome.submit_event', event_type: '')
  end
end
