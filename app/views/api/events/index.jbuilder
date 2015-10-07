 json.array! @events do |event|
  json.id event.id
  json.title event.title
  json.subtitle event.subtitle
  json.length event.length
  json.language event.language
  json.abstract event.abstract
  json.description event.description
  json.event_type_id event.event_type_id
  json.track_id event.track_id
  json.participant_user_ids event.participations.map(&:participant_id)
end
