class DropDefaultValueForLengthInEvents < ActiveRecord::Migration[4.2]
  def change
    change_column_default(:events, :length, nil)
  end
end
