class CreateCallForParticipations < ActiveRecord::Migration[4.2]
  def change
    create_table :call_for_participations do |t|
      t.references :conference, index: true, foreign_key: true
      t.datetime :opens_at
      t.datetime :closes_at

      t.timestamps null: false
    end
  end
end
