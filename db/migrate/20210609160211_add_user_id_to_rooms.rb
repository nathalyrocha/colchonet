class AddUserIdToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :user_id, :integer
    add_index :room, :user_id
  end
end
