class AddReferentialIntegrity < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :call_for_participations, :conferences
    add_foreign_key :call_for_participations, :conferences, on_delete: :cascade

    add_foreign_key :conference_translations, :conferences, on_delete: :cascade

    add_foreign_key :conflict_counts, :events, column: :left_id, on_delete: :cascade
    add_foreign_key :conflict_counts, :events, column: :right_id, on_delete: :cascade

    add_foreign_key :event_type_translations, :event_types, on_delete: :cascade

    remove_foreign_key :event_types, :conferences
    add_foreign_key :event_types, :conferences, on_delete: :cascade

    add_foreign_key :hall_translations, :halls, on_delete: :cascade

    add_foreign_key :halls, :conferences, on_delete: :cascade

    add_foreign_key :personal_profiles, :users, on_delete: :cascade
    add_foreign_key :personal_profiles, :conferences

    add_foreign_key :propositions, :users, column: :proposer_id

    add_foreign_key :slots, :halls, on_delete: :cascade
    add_foreign_key :slots, :events, on_delete: :nullify

    add_foreign_key :track_translations, :tracks, on_delete: :cascade

    add_foreign_key :tracks, :conferences, on_delete: :cascade

    add_foreign_key :volunteer_team_translations, :volunteer_teams, on_delete: :cascade

    remove_foreign_key :volunteer_teams, :conferences
    add_foreign_key :volunteer_teams, :conferences, on_delete: :cascade

    add_foreign_key :volunteer_teams_volunteers, :volunteers, on_delete: :cascade
    add_foreign_key :volunteer_teams_volunteers, :volunteer_teams, on_delete: :cascade
  end
end
