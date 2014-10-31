class Conference < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :email, presence: true, format: {with: /\A[^@]+@[^@]+\z/}
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_is_before_start_date

  translates :title, :description

  has_many :tracks, -> { order('id asc') }
  has_many :events, through: :tracks
  has_many :candidate_speakers, through: :events
  has_many :halls

  scope :future, -> { where('start_date >= ?', Date.today).order('start_date ASC') }

  def self.current
    future.first || last
  end

  private

  def end_date_is_before_start_date
    if start_date.present? and end_date.present? and start_date > end_date
      errors.add(:end_date, :cannot_be_before_start_date)
    end
  end
end
