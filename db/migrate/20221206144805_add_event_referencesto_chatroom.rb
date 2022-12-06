class AddEventReferencestoChatroom < ActiveRecord::Migration[7.0]
  def change
    add_reference :chatrooms, :event, foreign_key: true
  end
end
