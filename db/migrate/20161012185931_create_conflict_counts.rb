class CreateConflictCounts < ActiveRecord::Migration
  def change
    create_table :conflict_counts do |t|
      t.references :left, index: true
      t.references :right, index: true
      t.integer :number_of_conflicts
    end

    add_index :conflict_counts, [:left_id, :right_id], unique: true
  end
end
