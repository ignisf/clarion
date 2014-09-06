# -*- coding: utf-8 -*-
class EventMailer < ActionMailer::Base
  def new_event_notification(event)
    @event = event
    mail(to: 'core@openfest.org', subject: "Ново предложение за #{@event.class.model_name.human.mb_chars.downcase.to_s}: #{@event.title}")
  end
end
