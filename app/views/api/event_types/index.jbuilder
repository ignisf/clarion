json.array! @event_types do |event_type|
  json.extract! event_type, :id
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
