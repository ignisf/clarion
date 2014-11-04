class Conference < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :email, presence: true, format: {with: /\A[^@]+@[^@]+\z/}
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_is_before_end_date

  translates :title, :description

  has_many :tracks, -> { order('id asc') }, dependent: :destroy
  has_many :events, through: :tracks
  has_many :candidate_speakers, through: :events
  has_many :halls, dependent: :destroy

  accepts_nested_attributes_for :tracks, :halls, reject_if: :all_blank, allow_destroy: true

  before_save :close_all_other_calls_for_papers

  private

  def close_all_other_calls_for_papers
    Conference.where.not(id: self.id).update_all call_for_papers_open: false
  end

  def start_date_is_before_end_date
    if start_date.present? and end_date.present? and start_date > end_date
      errors.add(:end_date, :cannot_be_before_start_date)
    end
  end
end
