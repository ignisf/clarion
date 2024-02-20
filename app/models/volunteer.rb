class Volunteer < ActiveRecord::Base
  TSHIRT_SIZES = [:s, :m, :l, :xl, :xxl, :xxxl]
  TSHIRT_CUTS = [:unisex, :female]
  FOOD_PREFERENCES = [:none, :vegetarian, :vegan]

  has_one_attached :picture

  validates :name, :language, :tshirt_size, :tshirt_cut, :food_preferences, presence: true
  validates :tshirt_size, inclusion: {in: TSHIRT_SIZES.map(&:to_s)}
  validates :tshirt_cut, inclusion: {in: TSHIRT_CUTS.map(&:to_s)}
  validates :food_preferences, inclusion: {in: FOOD_PREFERENCES.map(&:to_s)}
  validates :email, format: {with: /\A[^@]+@[^@]+\z/}, presence: true
  validates :phone, presence: true, format: {with: /\A[+\- \(\)0-9]+\z/}
  validates :volunteer_teams, presence: true
  validate :volunteer_teams_belong_to_conference

  phony_normalize :phone, default_country_code: "BG"

  belongs_to :conference
  has_and_belongs_to_many :volunteer_teams

  before_create :assign_unique_id
  after_create :send_notification_to_organizers
  after_create :send_notification_to_volunteer

  private

  def assign_unique_id
    self.unique_id = Digest::SHA256.hexdigest(SecureRandom.uuid)
  end

  def send_notification_to_organizers
    VolunteerMailer.team_notification(self).deliver_later
  end

  def send_notification_to_volunteer
    VolunteerMailer.volunteer_notification(self).deliver_later
  end

  def volunteer_teams_belong_to_conference
    conference_volunteer_teams = conference.volunteer_teams
    unless volunteer_teams.all? { |team| conference_volunteer_teams.include? team }
      errors.add :volunteer_teams, :invalid_volunteer_team
    end
  end
end
