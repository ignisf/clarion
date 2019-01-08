require "rails_helper"

feature 'Conference management' do
  before do
    Rails.application.load_seed
  end

  scenario 'Creating a new conference' do
    sign_in_as_admin
    visit management_root_path
    expect(page).to_not have_content "FooConf"
    create_new_conference
    visit management_root_path
    expect(page).to have_content "FooConf"
  end

  scenario 'Enabling the call for papers of a conference' do
    sign_in_as_admin
    create_new_conference
    visit root_path
    expect(page).to have_link I18n.t('views.welcome.submit_event', event_type: '')
    visit management_root_path
    click_on_first_conference_in_management_root
    click_on I18n.t('management.conferences.show.cfp_status')
    expect(page).to_not have_link I18n.t('views.welcome.submit_event', event_type: '')
  end

  scenario 'Editing an existing conference' do
    sign_in_as_admin
    create_new_conference
    click_on I18n.t('actions.edit.button', model: Conference.model_name.human)
    fill_in Conference.human_attribute_name(:title), with: 'FooBarBazConf'
    page.find('.btn.btn-primary').click
    expect(page).to have_content 'FooBarBazConf'
  end

  scenario 'Deleting a newly created conference', js: true do
    sign_in_as_admin
    create_new_conference(host_name: '127.0.0.1')
    click_on 'Clarion'
    expect(page).to have_content 'FooConf'
    click_on_first_conference_in_management_root
    accept_confirm do
      click_on I18n.t('actions.destroy.button', model: Conference.model_name.human)
    end
    visit management_root_path
    expect(page).to_not have_content 'FooConf'
  end
end
