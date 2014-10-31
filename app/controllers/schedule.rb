class Schedule
  include ActiveModel::Model
  attr_accessor :hall, :slots

  def self.for_conference(conference)
    schedule = {}
    conference.halls.each do |hall|
      schedule[hall.id] = hall.slots.includes(:event, event: [:speakers]).where('starts_at < ?', Date.tomorrow).where.not(event_id: nil).order(:starts_at).map do |slot|
        {
          title: slot.event.title,
          subtitle: slot.event.subtitle,
          startTime: slot.starts_at,
          endTime: slot.ends_at,
          speakers: slot.event.speakers.map do |speaker|
            {
              name: speaker.name,
              description: speaker.biography
            }
          end
        }
      end
    end
    schedule
  end
end
