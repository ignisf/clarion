class RemoveNotNullConstraintOnConferenceTitle < ActiveRecord::Migration
  def change
    change_column :conferences, :title, :string, null: true
  end
end
