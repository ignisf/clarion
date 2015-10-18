@tracks.each do |track|
  json.set! track.id do
    json.color track.color
    json.foreground_color track.foreground_color
    json.css_class track.css_class
    json.css_style track.css_style
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
