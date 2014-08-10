class Workshop < Event
  validates :length, numericality: {greater_than_or_equal_to: 30, less_than_or_equal_to: 120}
end
