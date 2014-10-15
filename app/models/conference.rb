class Conference < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :email, presence: true, format: {with: /\A[^@]+@[^@]+\z/}
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_is_before_start_date

  translates :title, :description

  has_many :tracks, -> { order('id asc') }, dependent: :destroy
  has_many :events, through: :tracks
  has_many :candidate_speakers, through: :events
  has_many :halls, dependent: :destroy

  accepts_nested_attributes_for :tracks, :halls, reject_if: :all_blank, allow_destroy: true

  scope :future, -> { where('start_date >= ?', Date.today).order('start_date ASC') }

  before_save :close_all_other_calls_for_papers

  def self.current
    future.first || last
  end

  def submissions_grouped_by_day
    submissions = Event.where(track: tracks, created_at: created_at..start_date)
    submissions = submissions.group('date(created_at)')
    submissions = submissions.select('created_at, count(id) as number')
    submissions.group_by { |s| s.created_at.to_date }
  end

  def submissions_grouped_by_confirmation_day
    submissions = Event.approved.where(track: tracks, created_at: created_at..start_date).where.not(confirmed_at: nil)
    submissions = submissions.group('date(confirmed_at)')
    submissions = submissions.select('confirmed_at, count(id) as number')
    submissions.group_by { |s| s.confirmed_at.to_date }
  end

  private

  def close_all_other_calls_for_papers
    if call_for_papers_open? and call_for_papers_open_changed?
      Conference.where.not(id: self.id).update_all call_for_papers_open: false
    end
  end

  def end_date_is_before_start_date
    if start_date.present? and end_date.present? and start_date > end_date
      errors.add(:end_date, :cannot_be_before_start_date)
    end
  end
end
