class EventDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def feedback_qr_code
    RQRCode::QRCode.new(h.new_event_feedback_url(event_id: id), level: :l)
  end

  def feedback_qr_code_as_svg
    feedback_qr_code.as_svg(shape_rendering: "crispEdges", module_size: 11, fill: "ffffff", offset: 10)
  end
end
