class MigrateTimestampToTimestampTz < ActiveRecord::Migration[5.2]
  def up
    transaction do
      execute 'DROP VIEW "participants"'
      execute "ALTER TABLE call_for_participations ALTER opens_at TYPE timestamptz USING opens_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE call_for_participations ALTER closes_at TYPE timestamptz USING closes_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE call_for_participations ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE call_for_participations ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE conference_translations ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE conference_translations ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE conferences ALTER start_date TYPE timestamptz USING start_date AT TIME ZONE 'UTC';"
      execute "ALTER TABLE conferences ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE conferences ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE conferences ALTER vote_data_updated_at TYPE timestamptz USING vote_data_updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE event_type_translations ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE event_type_translations ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE event_types ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE event_types ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE events ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE events ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE events ALTER acceptance_notification_sent_at TYPE timestamptz USING acceptance_notification_sent_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE feedbacks ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE feedbacks ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE hall_translations ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE hall_translations ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE halls ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE halls ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE participations ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE participations ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE personal_profiles ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE personal_profiles ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE propositions ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE propositions ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE propositions ALTER confirmed_at TYPE timestamptz USING confirmed_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE slots ALTER starts_at TYPE timestamptz USING starts_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE slots ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE slots ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE track_translations ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE track_translations ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE tracks ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE tracks ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE users ALTER reset_password_sent_at TYPE timestamptz USING reset_password_sent_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE users ALTER remember_created_at TYPE timestamptz USING remember_created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE users ALTER current_sign_in_at TYPE timestamptz USING current_sign_in_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE users ALTER last_sign_in_at TYPE timestamptz USING last_sign_in_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE users ALTER confirmed_at TYPE timestamptz USING confirmed_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE users ALTER confirmation_sent_at TYPE timestamptz USING confirmation_sent_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE users ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE users ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE volunteer_team_translations ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE volunteer_team_translations ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE volunteer_teams ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE volunteer_teams ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE volunteers ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE volunteers ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE volunteerships ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'UTC';"
      execute "ALTER TABLE volunteerships ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'UTC';"
      execute 'CREATE VIEW "participants" AS ' \
              'SELECT "users"."id" AS "participant_id", ' \
                     '"users"."email" AS personal_email, ' \
                     '"users"."language" AS language, ' \
                     '"participations"."id" AS "participation_id", ' \
                     '"personal_profiles"."id" AS "personal_profile_id",' \
                     '"personal_profiles".* FROM "users" ' \
              'INNER JOIN "participations"    ON "users"."id" = "participations"."participant_id" ' \
              'INNER JOIN "events"            ON "events"."id" = "participations"."event_id"' \
              'INNER JOIN "conferences"       ON "events"."conference_id" = "conferences"."id"' \
              'LEFT JOIN "personal_profiles"  ON "personal_profiles"."conference_id" = "events"."conference_id"' \
                                            'AND "personal_profiles"."user_id" = "users"."id";'
    end
  end
end
