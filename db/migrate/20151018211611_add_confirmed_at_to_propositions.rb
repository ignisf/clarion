class AddConfirmedAtToPropositions < ActiveRecord::Migration[4.2]
  def change
    add_column :propositions, :confirmed_at, :timestamp
  end
end
