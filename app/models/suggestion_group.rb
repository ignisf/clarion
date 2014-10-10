class SuggestionGroup
  include ActiveModel::Model
  attr_accessor :speaker, :suggestions

  def self.where(conditions = {})
    Event.joins(:track).includes(:user).where(conditions).group_by(&:user).map do |speaker, suggestions|
      SuggestionGroup.new speaker: speaker, suggestions: suggestions
    end.sort_by { |group| group.speaker.name }
  end

  def self.for_conference(conference, conditions = {})
    where conditions.merge({tracks: {conference_id: conference.id}})
  end
end
