class Public::EventFeedbacksController < Public::ApplicationController
  def new
    @feedback = approved_events.find(params[:event_id]).feedbacks.build
  end

  def create
    @feedback = approved_events.find(params[:event_id]).feedbacks.build(feedback_params)
    @feedback.ip_address = request.remote_ip
    @feedback.session_id = session.id

    if @feedback.save
      flash[:notice] = I18n.t('public.event_feedbacks.new.success')
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:author_email, :rating, :comment)
  end

  def approved_events
    current_conference.events.joins(:proposition).approved
  end
end
