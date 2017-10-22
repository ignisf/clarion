class Public::EventFeedbacksController < Public::ApplicationController
  def new
    @feedback = approved_events.find(params[:event_id]).feedbacks.build
  end

  def create
    @feedback = approved_events.find(params[:event_id]).feedbacks.build(feedback_params)

    if @feedback.save
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
