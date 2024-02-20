class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :personal_profiles, dependent: :destroy
  has_many :lectures
  has_many :workshops
  has_many :propositions, foreign_key: :proposer_id
  has_many :events, through: :propositions, source: :proposable, source_type: "Event"
  has_many :feedbacks, through: :events
  has_many :feedbacks_with_comment, -> { where.not(comment: [nil, '']) }, through: :events

  has_many :participations, foreign_key: :participant_id
  has_many :events_participated_in, through: :participations, source: :event
  has_many :volunteerships, foreign_key: :volunteer_id

  include FeedbackReceiving

  def average_rating
    return nil unless rated?
    ratings_per_event = feedbacks.group(:feedback_receiving_type,
                                        :feedback_receiving_id).average(:rating).values
    BigDecimal(ratings_per_event.reduce(&:+)) / BigDecimal(ratings_per_event.size)
  end

  def find_or_build_personal_profile(conference, params = {})
    current_profile = personal_profile(conference)
    if current_profile.present?
      current_profile.assign_attributes params
      current_profile
    else
      build_personal_profile(conference, params)
    end
  end

  def build_personal_profile(conference, params = {})
    if personal_profiles.last.present?
      new_personal_profile = personal_profiles.last.try(:dup)
      new_personal_profile.picture.attach(personal_profiles.last.picture.blob)
    else
      new_personal_profile = personal_profiles.build
    end
    new_personal_profile.conference = conference
    new_personal_profile.assign_attributes params
    new_personal_profile
  end

  def personal_profile(conference)
    personal_profiles.find_by(conference_id: conference.id)
  end

  default_scope { order id: :desc }

  def toggle_admin!
    update admin: !admin
  end
end
