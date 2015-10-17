@halls.each do |hall|
  json.set! hall.id do
    json.extract! hall, :name
  end
end
