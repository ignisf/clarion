class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :speaker_profile
  has_many :lectures
  has_many :workshops
  has_many :events

  accepts_nested_attributes_for :speaker_profile, update_only: true

  default_scope { order id: :desc }

  def name
    speaker_profile.try(:name) || email
  end

  def toggle_admin!
    update admin: !admin
  end

  def profile_picture
    if speaker_profile.present?
      speaker_profile.picture
    else
      PictureUploader.new
    end
  end
end
