class ChangeEventStateDefaults < ActiveRecord::Migration
  def up
    execute 'UPDATE events SET state = 0'
    change_column :events, :state, :integer, null: false, default: 0
  end

  def down
    change_column :events, :state, :integer, null: true
  end
end
