class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :personal_profiles, dependent: :destroy
  has_many :lectures
  has_many :workshops
  has_many :events
  has_one :personal_profile, Proc.new { |user, conference| user.personal_profiles }

  default_scope { order id: :desc }

  def duplicate_last_personal_profile(conference)
    if personal_profiles.any?
      new_personal_profile = personal_profiles.last.dup
      new_personal_profile.conference = conference
      new_personal_profile
    end
  end

  def find_or_initialize_personal_profile(conference)
    if personal_profile(conference).present?
      personal_profile(conference)
    elsif personal_profiles.any?
      duplicate_last_personal_profile(conference)
    else
      personal_profiles.build(conference: conference)
    end
  end

  def toggle_admin!
    update admin: !admin
  end

  def clone_recent_profile(new_conference)
    recent_profile = personal_profiles.order('created_at DESC').first

    personal_profiles.build(conference: new_conference) do |new_profile|
      if recent_profile.present?
        new_profile.attributes = recent_profile.attributes.except(
          "id", "created_at", "updated_at", "conference_id"
        )
        new_profile.remote_picture_url = recent_profile.picture.url
      end
    end
  end
end
