class AddVoteDataToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :number_of_votes, :integer
    add_column :events, :rank, :integer
  end
end
