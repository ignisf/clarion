class AddConferenceIdToVolunteers < ActiveRecord::Migration[4.2]
  def change
    add_reference :volunteers, :conference, index: true, foreign_key: true
  end
end
