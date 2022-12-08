class ChangeCarPooling < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :passengers, :integer
  end
end
