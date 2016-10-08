class EventSearch
  include SearchObject.module

  option(:title)         { |scope, value| scope.where title: value }
  option(:language)      { |scope, value| scope.where language: value }
  option(:track_id)      { |scope, value| scope.where track_id: value }
  option(:event_type_id) { |scope, value| scope.where event_type_id: value }
  option(:status)        { |scope, value| scope.joins(:proposition).where(propositions: {status: value}) }
end
