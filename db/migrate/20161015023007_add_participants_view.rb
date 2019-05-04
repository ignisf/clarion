class AddParticipantsView < ActiveRecord::Migration[4.2]
  PARTICIPANTS_SQL = <<~EOS
    CREATE VIEW "participants" AS
    SELECT "users"."id" AS "participant_id",
           "users"."email" AS personal_email,
           "users"."language" AS language,
           "participations"."id" AS "participation_id",
           "personal_profiles"."id" AS "personal_profile_id",
           "personal_profiles".* FROM "users"
    INNER JOIN "participations"    ON "users"."id" = "participations"."participant_id"
    INNER JOIN "events"            ON "events"."id" = "participations"."event_id"
    INNER JOIN "conferences"       ON "events"."conference_id" = "conferences"."id"
    LEFT JOIN "personal_profiles"  ON "personal_profiles"."conference_id" = "events"."conference_id"
                                  AND "personal_profiles"."user_id" = "users"."id";
  EOS

  def up
    execute PARTICIPANTS_SQL
  end

  def down
    execute 'DROP VIEW "participants"'
  end
end
