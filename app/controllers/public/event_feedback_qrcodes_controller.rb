class Public::EventFeedbackQrcodesController < Public::ApplicationController
  def show
    event = current_conference.events.joins(:proposition).approved.find(params[:event_id])

    respond_to do |format|
      format.svg do
        render(inline: helpers.feedback_qr_code_as_svg(event.id),
               filename: "feedback_qr_code_#{event.id}.svg")
      end
    end
  end
end
