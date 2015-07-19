class Conference < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :email, presence: true, format: {with: /\A[^@]+@[^@]+\z/}
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_is_before_end_date

  translates :title, :description

  has_many :tracks
  has_many :halls
  has_many :events, through: :tracks
  has_many :event_types
  has_one :call_for_participation, dependent: :destroy
  has_many :participant_profiles, class_name: 'PersonalProfile'

  accepts_nested_attributes_for :tracks, :halls, :event_types, reject_if: :all_blank, allow_destroy: true

  after_create :create_call_for_participation

  def submissions_grouped_by_day
    submissions = events.group('date(events.created_at)').select('events.created_at, count(events.id) as number')
    submissions.group_by { |s| s.created_at.to_date }
  end

  def submissions_grouped_by_confirmation_day
    submissions = events.approved.confirmed.group('date(events.confirmed_at)').select('events.confirmed_at, count(events.id) as number')
    submissions.group_by { |s| s.confirmed_at.to_date }
  end

  private

  def start_date_is_before_end_date
    if start_date.present? and end_date.present? and start_date > end_date
      errors.add(:end_date, :cannot_be_before_start_date)
    end
  end
end
