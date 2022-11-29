class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating_event
      t.integer :rating_difficulty
      t.integer :rating_spot
      t.text :content

      t.timestamps
    end
  end
end
