class ConvertConferencesEndDateToTimestampWithTz < ActiveRecord::Migration[5.2]
  def up
    transaction do
      execute "ALTER TABLE conferences ALTER end_date TYPE timestamptz USING end_date AT TIME ZONE 'UTC';"
    end
  end
end
