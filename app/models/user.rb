class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :personal_profiles, dependent: :destroy
  has_many :lectures
  has_many :workshops
  has_many :events

  def build_personal_profile(conference, params = {})
    new_personal_profile = personal_profiles.last.dup || personal_profiles.build
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
