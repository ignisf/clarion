class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :personal_profiles, dependent: :destroy
  has_many :lectures
  has_many :workshops
  has_many :events

  accepts_nested_attributes_for :personal_profiles, update_only: true

  default_scope { order id: :desc }

  def personal_profile(conference)
    personal_profiles.find_by!(conference_id: conference.id)
  end

  def toggle_admin!
    update admin: !admin
  end
end
