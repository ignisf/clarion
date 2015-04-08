class RemoveNotNullConstraintOnConferenceDescription < ActiveRecord::Migration
  def change
    change_column :conferences, :description, :text, null: true
  end
end
