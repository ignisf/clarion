json.array! @tracks do |track|
  json.extract! track, :id
  json.name do
    track.translations.each do |translation|
      json.set! translation.locale, translation.name
    end
  end
  json.description do
    track.translations.each do |translation|
      json.set! translation.locale, translation.description
    end
  end
end
