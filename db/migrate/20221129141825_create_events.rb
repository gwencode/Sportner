class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.string :name
      t.datetime :date
      t.text :description
      t.integer :max_people
      t.string :meeting_point
      t.boolean :car_pooling, default: false
      t.integer :passengers, default: 3
      t.references :user, null: false, foreign_key: true
      t.references :spot, foreign_key: true
      t.references :run_detail, foreign_key: true
      t.string :difficulty

      t.timestamps
    end
  end
end
