class Lecture < Event
  validates :length, numericality: {greater_than_or_equal_to: 40, less_than_or_equal_to: 45}
end
