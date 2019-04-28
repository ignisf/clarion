class EventSearch
  include SearchObject.module(:sorting)

  option(:title)         { |scope, value| scope.where title: value }
  option(:language)      { |scope, value| scope.where language: value }
  option(:track_id)      { |scope, value| scope.where track_id: value }
  option(:event_type_id) { |scope, value| scope.where event_type_id: value }
  option(:status)        { |scope, value| scope.joins(:proposition).where(propositions: {status: value}) }
  option(:confirmed)     { |scope, value| scope.joins(:proposition).approved.where.not(propositions: {confirmed_at: nil}) }
  option(:not_confirmed) { |scope, value| scope.joins(:proposition).approved.where(propositions: {confirmed_at: nil}) }

  sort_by "title"
  config[:defaults]["sort"] = "#{config[:sort_attributes].first} asc"
end
