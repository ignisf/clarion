module EventsHelper
  def links_to_event_participants_for(event)
    event.participants_with_personal_profiles.map do |participant|
      if participant.has_personal_profile?
        link_to icon(:user, participant.name),
          management_conference_personal_profile_path(participant.personal_profile_id, conference_id: event.conference.id)
      else
        link_to icon('user-plus', participant.personal_email),
          new_management_conference_personal_profile_path(conference_id: event.conference.id,
                                                          user_id: participant.id),
          title: t('management.events.event.create_profile'), class: 'bg-danger'
      end
    end.join(', ').html_safe
  end

  def participant_names_with_emails(event)
    event.participants.map do |participant|
      if participant.personal_profile(event.conference).present?
        profile = participant.personal_profile(event.conference)
        "#{profile.name} <#{participant.email}>"
      else
        participant.email
      end
    end
  end

  def participant_names(event)
    event.participants.map do |participant|
      if participant.personal_profile(event.conference).present?
        profile = participant.personal_profile(event.conference)
        "#{profile.name}"
      else
        nil
      end
    end.compact
  end
end
