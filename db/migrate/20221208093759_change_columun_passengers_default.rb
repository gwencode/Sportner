class ChangeColumunPassengersDefault < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :passengers, :integer, default: 0
  end
end
