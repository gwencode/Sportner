class CreateMeteos < ActiveRecord::Migration[7.0]
  def change
    create_table :meteos do |t|
      t.references :event, null: false, foreign_key: true
      t.datetime :report_datetime
      t.string :weather
      t.float :temperature
      t.integer :wind_km
      t.integer :wind_kt
      t.integer :wind_direction
      t.float :wave_height
      t.integer :wave_period
      t.integer :wave_direction
      t.integer :sea_temperature
      t.integer :coef
      t.string :previous_tide_type
      t.time :previous_tide_time
      t.string :next_tide_type
      t.time :next_tide_time

      t.timestamps
    end
  end
end
