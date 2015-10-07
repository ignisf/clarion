json.array! @speakers do |speaker|
  json.extract! speaker, :user_id, :twitter, :github, :biography, :public_email, :organisation, :last_name, :first_name
  json.picture speaker.picture.serializable_hash
end
