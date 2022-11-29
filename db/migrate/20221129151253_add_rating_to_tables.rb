class AddRatingToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :rating, :float
    add_column :spots, :rating, :float
    add_column :run_details, :rating, :float
  end
end
