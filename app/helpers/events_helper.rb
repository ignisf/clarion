module EventsHelper
  def participant_names_or_emails(event)
    event.participants.map do |participant|
      participant.try(:personal_profile, current_conference).try(:name) ||
        participant.personal_profiles.last.try(:name) ||
        participant.email
    end
  end
end
