@slots.each do |slot|
  json.set! slot.id do
    json.extract! slot, :hall_id, :event_id, :starts_at, :ends_at
  end
end
