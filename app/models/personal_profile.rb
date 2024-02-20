class PersonalProfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :conference

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :picture, presence: true
  validates :mobile_phone, phony_plausible: true, presence: true
  validates :biography, presence: true
  validates :public_email, format: {with: /\A[^@]+@[^@]+\z/}, allow_blank: true
  validates :twitter, format: {with: /\A[a-z0-9_]{1,15}\z/i}, allow_blank: true
  validates :github, format: {with: /\A[a-z0-9][a-z0-9\-]*\z/i}, allow_blank: true

  phony_normalize :mobile_phone, default_country_code: "BG", add_plus: false

  has_one_attached :picture

  accepts_nested_attributes_for :user

  def twitter=(handle)
    write_attribute :twitter, handle.gsub(/\A@/, "") if handle
  end

  def name
    "#{first_name} #{last_name}"
  end
end
