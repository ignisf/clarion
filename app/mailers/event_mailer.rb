class EventMailer < ActionMailer::Base
  def confirmation_request(event)
    @event = event
    I18n.locale = @event.proposer.language
    attachments['feedback-link-qr-code.svg'] = {
      mime_type: 'image/svg+xml',
      content: helpers.feedback_qr_code_as_svg(@event.id)
    }
    mail to: @event.proposer.email,
         from: "program@openfest.org",
         subject: I18n.t("event_mailer.acceptance_notification.subject",
           conference: @event.conference.title,
           submission_type: @event.event_type.name.mb_chars.downcase.to_s,
           title: @event.title)
  end

  def rejection_notification(event)
    @event = event
    I18n.locale = @event.proposer.language

    mail to: @event.proposer.email,
         from: "program@openfest.org",
         subject: I18n.t("event_mailer.rejection_notification.subject",
           conference: @event.conference.title,
           submission_type: @event.event_type.name.mb_chars.downcase.to_s,
           title: @event.title)
  end
end
