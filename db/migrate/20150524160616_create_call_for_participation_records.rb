class Conference           < ActiveRecord::Base; end
class CallForParticipation < ActiveRecord::Base; end

class CreateCallForParticipationRecords < ActiveRecord::Migration[4.2]
  def change
    Conference.all.each do |c|
      CallForParticipation.create!(conference_id: c.id)
    end
  end
end
