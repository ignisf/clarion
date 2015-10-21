class CreateJoinTableVolunteerVolunteerTeam < ActiveRecord::Migration
  def change
    create_join_table :volunteers, :volunteer_teams do |t|
      t.index [:volunteer_id, :volunteer_team_id], name: 'volunteer_id_volunteer_team_id'
      t.index [:volunteer_team_id, :volunteer_id], name: 'volunteer_team_id_volunteer_id'
    end
  end
end
