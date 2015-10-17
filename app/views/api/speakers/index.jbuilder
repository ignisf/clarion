@speakers.each do |speaker|
  json.set! speaker.id do
    json.extract! speaker, :twitter, :github, :biography, :public_email, :organisation, :last_name, :first_name
    json.picture speaker.picture.serializable_hash
  end
end
