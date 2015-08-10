class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :participant, index: true
      t.references :event, index: true, foreign_key: true
      t.boolean :approved, default: false

      t.timestamps null: false
    end

    add_foreign_key :participations, :users, column: :participant_id
  end
end
