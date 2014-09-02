# -*- coding: utf-8 -*-
class EventMailer < ActionMailer::Base
  def new_event_notification(event)
    @users = User.where(admin: true)
    @event = event
    mail(to: @users.map(&:email), subject: "Ново предложение за #{@event.class.model_name.human.mb_chars.downcase.to_s}: #{@event.title}")
  end
end
