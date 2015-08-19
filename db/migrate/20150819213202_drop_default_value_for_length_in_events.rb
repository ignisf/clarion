class DropDefaultValueForLengthInEvents < ActiveRecord::Migration
  def change
    change_column_default(:events, :length, nil)
  end
end
