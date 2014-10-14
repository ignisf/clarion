class AddCallForPapersStatusToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :call_for_papers_open, :boolean
  end
end
