class Track < ActiveRecord::Base
  belongs_to :conference
  has_many :events

  validates :name, presence: true
  validates :color, presence: true, format: {with: /\A[a-f0-9]{6}\z/i}

  translates :name, :description

  def color=(hex_triplet)
    write_attribute :color, hex_triplet.gsub(/\A#/,'') if hex_triplet
  end
end
