class Volunteership < ActiveRecord::Base
  include Proposable

  belongs_to :volunteer_team
  belongs_to :volunteer, class_name: 'User'
  has_one :conference, through: :volunteer_team

  def proposable_title
    volunteer.email
  end

  def proposable_description
    {
      volunteer_email: volunteer.email,
      volunteer_team: volunteer_team.name,
    }
  end
end
