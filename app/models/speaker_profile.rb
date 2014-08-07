class SpeakerProfile < ActiveRecord::Base
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :photo_url, presence: true
  validates :mobile_phone, phony_plausible: true, presence: true
  validates :biography, presence: true

  phony_normalize :mobile_phone, default_country_code: 'BG'
end
