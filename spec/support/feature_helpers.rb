module FeatureHelpers
  def sign_in_as_admin
    visit management_root_path
    within "section.content" do
      fill_in User.human_attribute_name(:email), with: "foo@example.com"
      fill_in User.human_attribute_name(:password), with: "123qweASD"
      click_on I18n.t(:login)
    end
  end

  def create_new_conference(title = "FooConf #{1.year.from_now.year}",
    host_name: "www.example.com",
    planned_cfp_end_date: 1.year.from_now,
    start_date: 1.year.from_now + 1.day,
    end_date: 1.year.from_now + 2.days)
    click_on I18n.t("actions.create.button", model: Conference.model_name.human)
    fill_in Conference.human_attribute_name(:title), with: title
    fill_in Conference.human_attribute_name(:email), with: "foo@example.com"
    fill_in Conference.human_attribute_name(:host_name), with: host_name
    select planned_cfp_end_date.year.to_s, from: "conference[planned_cfp_end_date(1i)]"
    select I18n.t("date.month_names")[planned_cfp_end_date.month], from: "conference[planned_cfp_end_date(2i)]"
    select planned_cfp_end_date.day.to_s, from: "conference[planned_cfp_end_date(3i)]"

    select start_date.year.to_s, from: "conference[start_date(1i)]"
    select I18n.t("date.month_names")[start_date.month], from: "conference[start_date(2i)]"
    select start_date.day.to_s, from: "conference[start_date(3i)]"

    select end_date.year.to_s, from: "conference[end_date(1i)]"
    select I18n.t("date.month_names")[end_date.month], from: "conference[end_date(2i)]"
    select end_date.day.to_s, from: "conference[end_date(3i)]"

    within ".form-group.conference_description" do
      fill_in Conference.human_attribute_name(:description), with: "Lorem"
    end

    within "#event_types" do
      fill_in EventType.human_attribute_name(:description), with: "Lorem"
      fill_in EventType.human_attribute_name(:minimum_length), with: "45"
      fill_in EventType.human_attribute_name(:maximum_length), with: "45"
    end

    within "#tracks" do
      fill_in Track.human_attribute_name(:description), with: "Lorem"
    end

    within "#volunteer_teams" do
      fill_in VolunteerTeam.human_attribute_name(:description), with: "Lorem"
    end

    page.find(".btn.btn-primary").click

    click_on I18n.t("management.conferences.show.cfp_status")
  end

  def sign_out
    click_on I18n.t("sessions.sign_out")
  end

  def register_a_new_user(visit_registration_path = true)
    if visit_registration_path
      click_on I18n.t("sessions.sign_in")
    end

    fill_in User.human_attribute_name(:email), with: "bar@example.com"
    fill_in User.human_attribute_name(:password), with: "123qweASD"
    fill_in User.human_attribute_name(:password_confirmation), with: "123qweASD"

    within ".form-actions" do
      page.find(".btn").click
    end
    visit(user_confirmation_path + "?confirmation_token=" + User.order(created_at: :desc).first.confirmation_token)
  end

  def sign_in_as_an_existing_user(visit_sign_in_path = true)
    if visit_sign_in_path
      click_on I18n.t("sessions.sign_in")
    end

    within "section.content" do
      fill_in User.human_attribute_name(:email), with: "bar@example.com"
      fill_in User.human_attribute_name(:password), with: "123qweASD"
      click_on I18n.t(:login)
    end
  end

  def submit_an_event_proposition(visit_event_submission_path = true)
    if visit_event_submission_path
      visit root_path
      click_on I18n.t("views.welcome.submit_event", event_type: Conference.first.event_types.first.name.downcase)
    end

    fill_in Event.human_attribute_name(:title), with: "This is just a sample title of an event"
    select Conference.first.tracks.first.name, from: Event.human_attribute_name(:track)
    fill_in Event.human_attribute_name(:length), with: "45"
    fill_in Event.human_attribute_name(:abstract), with: "Lorem"
    fill_in Event.human_attribute_name(:description), with: "Ipsum"
    check Event.human_attribute_name(:agreement)

    click_on I18n.t("helpers.submit.event.create")
  end

  def fill_in_personal_profile
    attach_file PersonalProfile.human_attribute_name(:picture), Rails.root.join("spec", "support", "picture.jpg")
    fill_in PersonalProfile.human_attribute_name(:first_name), with: "Foo"
    fill_in PersonalProfile.human_attribute_name(:last_name), with: "Bar"
    fill_in PersonalProfile.human_attribute_name(:mobile_phone), with: "+359883123456"
    fill_in PersonalProfile.human_attribute_name(:biography), with: "Lorem"

    click_on I18n.t("helpers.submit.create", model: PersonalProfile.model_name.human)
  end

  def fill_in_volunteer_profile
    attach_file Volunteer.human_attribute_name(:picture), Rails.root.join("spec", "support", "picture.jpg")
    fill_in Volunteer.human_attribute_name(:name), with: "Volunteer Foo"
    fill_in Volunteer.human_attribute_name(:email), with: "foo@example.com"
    fill_in Volunteer.human_attribute_name(:phone), with: "+359666666"
    check VolunteerTeam.first.name

    click_on I18n.t("helpers.submit.volunteer.create")
  end

  def verify_the_event_is_submitted
    sign_in_as_admin
    click_on_first_conference_in_management_root
    click_on Event.model_name.human(count: 2).capitalize
    expect(page).to have_content "This is just a sample title of an event"
  end

  def click_on_first_conference_in_management_root
    click_on I18n.t("actions.view.button", model: Conference.model_name.human), match: :first
  end
end
