@halls.each do |hall|
  json.set! hall.id do
    json.name do
      hall.translations.each do |translation|
        json.set! translation.locale, translation.name
      end
    end
  end
end
