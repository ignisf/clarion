require "rails_helper"

feature 'Call for papers' do
  before do
    Rails.application.load_seed
  end

  scenario "A new user submits an event proposition" do
    sign_in_as_admin
    create_new_conference
    sign_out

    visit root_path
    click_on I18n.t('views.welcome.submit_event', event_type: Conference.first.event_types.first.name.try(:mb_chars).try(:downcase))
    click_on I18n.t(:registration)

    register_a_new_user(false)

    submit_an_event_proposition

    expect(page).to have_content I18n.t('views.events.event_successfully_created', event_type: Event.last.event_type.name.mb_chars.downcase)
    expect(page).to have_content I18n.t(:please_fill_in_your_speaker_profile)

    fill_in_personal_profile

    expect(page).to have_content I18n.t('views.personal_profiles.successfully_created')

    click_on I18n.t('views.navigation.my_submissions')

    expect(page).to have_content(Event.last.event_type.name + ' "This is just a sample title of an event"')

    sign_out

    verify_the_event_is_submitted
  end

  scenario "A returning user submits an event proposition" do
    time_travel_to(2.years.ago) do
      sign_in_as_admin
      create_new_conference
      sign_out

      visit root_path
      click_on I18n.t('views.welcome.submit_event', event_type: Conference.first.event_types.first.name.try(:mb_chars).try(:downcase))
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
    click_on I18n.t('views.welcome.submit_event', event_type: Conference.first.event_types.first.name.try(:mb_chars).try(:downcase))

    sign_in_as_an_existing_user(false)

    submit_an_event_proposition(false)
    expect(page).to have_content I18n.t(:please_fill_in_your_speaker_profile)
    click_on I18n.t('helpers.submit.create', model: PersonalProfile.model_name.human)

    expect(page).to have_content I18n.t('views.personal_profiles.successfully_created')

    click_on I18n.t('views.navigation.my_submissions')

    expect(page).to have_content(Event.last.event_type.name + ' "This is just a sample title of an event"')

    sign_out

    verify_the_event_is_submitted
  end


  scenario "A returning user resets their password and submits an event proposition" do
    time_travel_to(2.years.ago) do
      sign_in_as_admin
      create_new_conference
      sign_out

      visit root_path
      click_on I18n.t('views.welcome.submit_event', event_type: Conference.first.event_types.first.name.try(:mb_chars).try(:downcase))
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
    click_on I18n.t('views.welcome.submit_event', event_type: Conference.first.event_types.first.name.try(:mb_chars).try(:downcase))

    click_on I18n.t('lostpass')
    fill_in User.human_attribute_name(:email), with: 'bar@example.com'
    click_on I18n.t(:send_lostpass_instructions)
    expect(page).to have_content I18n.t('devise.passwords.send_instructions')
    visit ActionMailer::Base.deliveries.last.body.raw_source.match(/https?:\/\/.*?(\/.*\w)/)[1]

    fill_in User.human_attribute_name(:password), with: 'foobarbaz'
    fill_in User.human_attribute_name(:password_confirmation), with: 'foobarbaz'
    click_on I18n.t(:change_pass)

    submit_an_event_proposition(false)
    expect(page).to have_content I18n.t(:please_fill_in_your_speaker_profile)
    click_on I18n.t('helpers.submit.create', model: PersonalProfile.model_name.human)

    expect(page).to have_content I18n.t('views.personal_profiles.successfully_created')

    click_on I18n.t('views.navigation.my_submissions')

    expect(page).to have_content(Event.last.event_type.name + ' "This is just a sample title of an event"')

    sign_out

    verify_the_event_is_submitted
  end
end
