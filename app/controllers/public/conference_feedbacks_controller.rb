class Public::ConferenceFeedbacksController < Public::ApplicationController
  def new
    @feedback = current_conference.feedbacks.build
  end

  def create
    @feedback = current_conference.feedbacks.build(feedback_params)
    @feedback.ip_address = request.remote_ip
    @feedback.session_id = session.id

    if @feedback.save
      flash[:notice] = I18n.t('public.conference_feedbacks.new.success')
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:author_email, :rating, :comment)
  end
end
