module FeedbackReceiving
  extend ActiveSupport::Concern

  def average_rating
    feedbacks.average(:rating)
  end

  def rated?
    feedbacks.size > 0
  end
end
