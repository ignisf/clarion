class AddConferenceIdToVolunteers < ActiveRecord::Migration
  def change
    add_reference :volunteers, :conference, index: true, foreign_key: true
  end
end
