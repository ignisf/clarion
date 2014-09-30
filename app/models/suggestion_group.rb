class SuggestionGroup
  include ActiveModel::Model
  attr_accessor :speaker, :suggestions

  def self.where(conditions = {})
    Event.joins(:track).includes(:user).where(conditions).group_by(&:user).map do |speaker, suggestions|
      SuggestionGroup.new speaker: speaker, suggestions: suggestions
    end
  end

  def self.for_conference(conference)
    where tracks: {conference_id: conference.id}
  end
end
