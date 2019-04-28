class RemovePropositionAcceptingFieldsFromPropositions < ActiveRecord::Migration[4.2]
  def change
    remove_reference :propositions, :proposition_accepting, index: true, polymorphic: true
  end
end
