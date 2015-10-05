class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :personal_profiles, dependent: :destroy
  has_many :lectures
  has_many :workshops
  has_many :propositions, foreign_key: :proposer_id
  has_many :events, through: :propositions, source: :proposable, source_type: 'Event'
  has_many :volunteerships, foreign_key: :volunteer_id

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
      CopyCarrierwaveFile::CopyFileService.new(personal_profiles.last, new_personal_profile, :picture).set_file
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
