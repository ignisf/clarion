@event_types.each do |event_type|
  json.set! event_type.id do
    json.name do
      event_type.translations.each do |translation|
        json.set! translation.locale, translation.name
      end
    end
    json.description do
      event_type.translations.each do |translation|
        json.set! translation.locale, translation.description
      end
    end
  end
end
