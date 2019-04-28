class RemoveNotNullConstraintOnConferenceTitle < ActiveRecord::Migration[4.2]
  def change
    change_column :conferences, :title, :string, null: true
  end
end
