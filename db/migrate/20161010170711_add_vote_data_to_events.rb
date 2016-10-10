class AddVoteDataToEvents < ActiveRecord::Migration
  def change
    add_column :events, :number_of_votes, :integer
    add_column :events, :rank, :integer
  end
end
