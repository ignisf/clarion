module EventsHelper
  def links_to_event_participants_for(event)
    event.participants.map do |participant|
      if participant.personal_profile(event.conference).present?
        profile = participant.personal_profile(event.conference)
        link_to icon(:user, profile.name),
          management_conference_personal_profile_path(profile, conference_id: event.conference.id)
      else
        link_to icon('user-plus', participant.email),
          new_management_conference_personal_profile_path(conference_id: event.conference.id,
                                                          user_id: participant.id),
          title: t('.create_profile'), class: 'bg-danger'
      end
    end.join(', ').html_safe
  end
end
