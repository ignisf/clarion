# coding: utf-8
class VolunteerMailer < ActionMailer::Base
  def team_notification(new_volunteer)
    @volunteer = new_volunteer

    mail(to: @volunteer.conference.email,
         subject: "Нов доброволец – #{@volunteer.name} <#{@volunteer.email}> за екип(и) #{@volunteer.volunteer_teams.map(&:name).join(', ')}")
  end

  def volunteer_notification(new_volunteer)
    @volunteer = new_volunteer
    I18n.locale = @volunteer.language
    mail(to: @volunteer.email,
         reply_to: @volunteer.conference.email,
         from: 'no-reply@openfest.org',
         subject: I18n.t('volunteer_mailer.success_notification.subject',
                         conference_name: @volunteer.conference.title))
  end
end
