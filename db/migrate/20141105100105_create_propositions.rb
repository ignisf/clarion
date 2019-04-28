class CreatePropositions < ActiveRecord::Migration[4.2]
  def change
    create_table :propositions do |t|
      t.references :proposer, index: true
      t.references :proposition_accepting, polymorphic: true
      t.index [:proposition_accepting_id, :proposition_accepting_type], name: "proposition_accepting_index"
      t.references :proposable, polymorphic: true, index: true
      t.integer :status

      t.timestamps
    end
  end
end
