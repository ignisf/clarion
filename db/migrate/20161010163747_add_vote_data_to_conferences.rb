class AddVoteDataToConferences < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :vote_data_endpoint, :string
    add_column :conferences, :number_of_ballots_cast, :integer
    add_column :conferences, :vote_data_updated_at, :datetime
  end
end
