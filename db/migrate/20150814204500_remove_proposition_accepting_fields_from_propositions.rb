class RemovePropositionAcceptingFieldsFromPropositions < ActiveRecord::Migration
  def change
    remove_reference :propositions, :proposition_accepting, index: true, foreign_key: true, polymorphic: true
  end
end
