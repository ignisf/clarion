class Track < ActiveRecord::Base
  belongs_to :conference
  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :color, presence: true, format: {with: /\A#?[a-f0-9]{6}\z/i}
  validates :description, presence: true

  translates :name, :description

  def color=(hex_triplet)
    write_attribute :color, hex_triplet.gsub(/\A#/,'') if hex_triplet
  end

  def color
    "##{read_attribute :color}"
  end
end
