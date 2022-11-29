class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :location
      t.string :spot_difficulty
      t.string :wave_type
      t.string :wave_direction
      t.string :bottom
      t.string :wave_height_infos
      t.string :tide_conditions
      t.string :danger

      t.timestamps
    end
  end
end
