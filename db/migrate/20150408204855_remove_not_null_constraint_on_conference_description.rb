class RemoveNotNullConstraintOnConferenceDescription < ActiveRecord::Migration[4.2]
  def change
    change_column :conferences, :description, :text, null: true
  end
end
