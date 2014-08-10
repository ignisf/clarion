class Conference < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :email, presence: true, format: {with: /\A[^@]+@[^@]+\z/}
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_is_before_start_date

  has_many :tracks
  has_many :events, through: :tracks

  scope :future, -> { where 'start_date >= ?', Date.today }
  scope :current, -> { future.first || last }

  private

  def end_date_is_before_start_date
    if start_date.present? and end_date.present? and start_date > end_date
      errors.add(:end_date, :cannot_be_before_start_date)
    end
  end
end
