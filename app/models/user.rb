class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :speaker_profile
  has_many :lectures
  has_many :workshops

  accepts_nested_attributes_for :speaker_profile, update_only: true

  def toggle_admin!
    update admin: !admin
  end
end
