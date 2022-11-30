class AddZipCityToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :zipcode, :string, null: false, default: ""
    add_column :users, :city, :string, null: false, default: ""
  end
end
