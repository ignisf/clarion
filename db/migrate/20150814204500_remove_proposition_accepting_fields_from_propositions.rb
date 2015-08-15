class RemovePropositionAcceptingFieldsFromPropositions < ActiveRecord::Migration
  def change
    remove_reference :propositions, :proposition_accepting, index: true, polymorphic: true
  end
end
