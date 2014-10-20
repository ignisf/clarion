# -*- coding: utf-8 -*-
class EventMailer < ActionMailer::Base
  def new_event_notification(event)
    @event = event
    mail(to: 'core@openfest.org', subject: "Ново предложение за #{@event.class.model_name.human.mb_chars.downcase.to_s}: #{@event.title}")
  end

  def acceptance_notification(event)
    @event = event
    I18n.locale = @event.language
    mail to: @event.user.email, from: 'program@openfest.org', subject: I18n.t('event_mailer.acceptance_notification.subject', conference: @event.conference.title, submission_type: @event.class.model_name.human.mb_chars.downcase.to_s, title: @event.title)
  end

  def acceptance_second_notification(event)
    @event = event
    I18n.locale = @event.language
    mail to: @event.user.email, from: 'program@openfest.org', subject: I18n.t('event_mailer.acceptance_notification.subject', conference: @event.conference.title, submission_type: @event.class.model_name.human.mb_chars.downcase.to_s, title: @event.title)
  end

  def rejection_notification(event)
    @event = event
    I18n.locale = 'bg' # XXX Change this when per-user locale is introduced in the user
    mail to: @event.user.email, from: 'program@openfest.org', subject:  "Предложението ви за #{@event.conference.title} за #{event.class.model_name.human.mb_chars.downcase.to_s} „#{@event.title}“ не е одобрено"
  end
end
