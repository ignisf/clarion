class Public::EventFeedbackQrcodesController < Public::ApplicationController
  def show
    event = current_conference.events.joins(:proposition).approved.find(params[:event_id])
    @qr = RQRCode::QRCode.new(new_event_feedback_url(event_id: event.id), level: :l)

    respond_to do |format|
      format.svg do
        render(inline: @qr.as_svg(shape_rendering: "crispEdges", module_size: 11, fill: "ffffff", offset: 10),
               filename: "feedback_qr_code_#{event.id}.svg")
      end
    end
  end
end
