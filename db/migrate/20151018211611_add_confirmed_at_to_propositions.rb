class AddConfirmedAtToPropositions < ActiveRecord::Migration
  def change
    add_column :propositions, :confirmed_at, :timestamp
  end
end
