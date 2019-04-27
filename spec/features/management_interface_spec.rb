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

  scenario 'Reviewing an event' do
    sign_in_as_admin
    create_new_conference
    submit_an_event_proposition(true)
    visit management_root_path
    click_on_first_conference_in_management_root
    click_on I18n.t('activerecord.models.event', count: 2).capitalize
    click_on I18n.t('actions.view.button', model: Event.model_name.human)
    expect(page).to have_content('This is just a sample title of an event')
  end

  scenario 'Editing an event' do
    sign_in_as_admin
    create_new_conference
    submit_an_event_proposition(true)
    visit management_root_path
    click_on_first_conference_in_management_root
    click_on I18n.t('activerecord.models.event', count: 2).capitalize
    expect(page).to have_content('This is just a sample title of an event')
    click_on I18n.t('actions.edit.button', model: Event.model_name.human)
    fill_in Event.human_attribute_name(:title), with: 'This is just a sample edited title of an event'
    click_on I18n.t('helpers.submit.event.update')
    expect(page).to have_content I18n.t('management.events.update.event_successfully_updated')
    expect(page).to have_content 'This is just a sample edited title of an event'
  end

  scenario 'Approving an event from its detailed view' do
    sign_in_as_admin
    create_new_conference
    submit_an_event_proposition(true)
    visit management_root_path
    click_on_first_conference_in_management_root
    click_on I18n.t('activerecord.models.event', count: 2).capitalize
    expect(page).to_not have_button I18n.t("status.approved")
    click_on I18n.t('actions.view.button', model: Event.model_name.human)
    click_on I18n.t("status.undecided")
    click_on I18n.t("status.approved")
    click_on I18n.t('activerecord.models.event', count: 2).capitalize
    expect(page).to have_button I18n.t("status.approved")
  end

  scenario 'Approving an event from the events index' do
    sign_in_as_admin
    create_new_conference
    submit_an_event_proposition(true)
    visit management_root_path
    click_on_first_conference_in_management_root
    click_on I18n.t('activerecord.models.event', count: 2).capitalize
    expect(page).to_not have_button I18n.t("status.approved")
    click_on I18n.t("status.undecided")
    click_on I18n.t("status.approved")
    expect(page).to have_button I18n.t("status.approved")
  end

  scenario 'Creating a profile for a submitter' do
    sign_in_as_admin
    create_new_conference
    submit_an_event_proposition(true)
    visit management_root_path
    click_on_first_conference_in_management_root
    click_on I18n.t('activerecord.models.personal_profile', count: 2).capitalize
    click_on I18n.t('actions.create.title', model: PersonalProfile.model_name.human)
    fill_in_personal_profile
    expect(page).to have_content I18n.t('management.personal_profiles.create.successfully_created')
    expect(page).to have_content 'Foo Bar'
  end

  scenario "Cloning the last profile of a submitter that did not update it when they submitted" do
    time_travel_to(2.years.ago) do
      sign_in_as_admin
      create_new_conference
      sign_out

      visit root_path
      click_on I18n.t('views.welcome.submit_event', event_type: Conference.first.event_types.first.name.downcase)
      click_on I18n.t(:registration)

      register_a_new_user(false)

      submit_an_event_proposition

      fill_in_personal_profile
      sign_out
    end

    sign_in_as_admin
    create_new_conference
    sign_out

    visit root_path
    click_on I18n.t('views.welcome.submit_event', event_type: Conference.first.event_types.first.name.downcase)

    sign_in_as_an_existing_user(false)

    submit_an_event_proposition(false)
    expect(page).to have_content I18n.t(:please_fill_in_your_speaker_profile)
    sign_out

    verify_the_event_is_submitted
    click_on I18n.t('activerecord.models.personal_profile', count: 2).capitalize
    expect(page).to have_text(I18n.t('management.personal_profiles.index.no_profile'))
    click_on I18n.t('actions.clone.title', model: PersonalProfile.model_name.human)
    expect(page).to have_text(I18n.t('management.personal_profiles.create.successfully_created'))
    click_on I18n.t('activerecord.models.personal_profile', count: 2).capitalize
    expect(page).to_not have_text(I18n.t('management.personal_profiles.index.no_profile'))
  end

end
