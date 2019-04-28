class Public::EventFeedbacksController < Public::ApplicationController
  def new
    if event.feedbacks.where(session_id: session.id).exists?
      @feedback = event.feedbacks.where(session_id: session.id).order(updated_at: :asc).last
    else
      @feedback = event.feedbacks.build
      @feedback.author_email = Feedback.where(session_id: session.id).order(updated_at: :asc).last.try(:author_email)
    end
  end

  def create
    @feedback = event.feedbacks.build(feedback_params)
    @feedback.ip_address = request.remote_ip
    @feedback.session_id = session.id

    if @feedback.save
      flash[:notice] = I18n.t("public.event_feedbacks.new.success")
      redirect_to conference_feedbacks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:author_email, :rating, :comment)
  end

  def event
    approved_events.find(params[:event_id])
  end

  def approved_events
    current_conference.events_of_all_editions.joins(:proposition).approved
  end
end
