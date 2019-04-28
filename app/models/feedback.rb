class Feedback < ActiveRecord::Base
  belongs_to :feedback_receiving, polymorphic: true

  validates :rating, presence: true, inclusion: {in: [2, 3, 4, 5, 6]}

  before_create :destroy_older_feedbacks_by_the_session

  private

  def destroy_older_feedbacks_by_the_session
    feedback_receiving.feedbacks.where(session_id: session_id).destroy_all
  end
end
