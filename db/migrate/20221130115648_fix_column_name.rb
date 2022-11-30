class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :run_details, :type, :run_type
  end
end
