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

  def toggle_admin!
    update admin: !admin
  end
end
