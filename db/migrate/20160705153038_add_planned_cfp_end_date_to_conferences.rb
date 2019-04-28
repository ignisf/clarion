class AddPlannedCfpEndDateToConferences < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :planned_cfp_end_date, :date
  end
end
