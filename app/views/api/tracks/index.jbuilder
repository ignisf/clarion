@tracks.each do |track|
  json.set! track.id do
    json.color track.color
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
end
