class AddCoordinatesToModels < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :favorite_spots, :latitude, :float
    add_column :favorite_spots, :longitude, :float
    add_column :spots, :latitude, :float
    add_column :spots, :longitude, :float
    add_column :run_details, :latitude, :float
    add_column :run_details, :longitude, :float
  end
end
