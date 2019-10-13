class Public::EventFeedbackQrcodesController < Public::ApplicationController
  def show
    event = current_conference.events.joins(:proposition).approved.find(params[:event_id]).decorate

    respond_to do |format|
      format.svg do
        render(inline: event.feedback_qr_code_as_svg,
               filename: "feedback_qr_code_#{event.id}.svg")
      end
    end
  end
end
