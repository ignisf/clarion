class AddCallForPapersStatusToConferences < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :call_for_papers_open, :boolean
  end
end
