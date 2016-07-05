class AddPlannedCfpEndDateToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :planned_cfp_end_date, :date
  end
end
