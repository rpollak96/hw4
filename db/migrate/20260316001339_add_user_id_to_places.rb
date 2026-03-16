class AddUserIdToPlaces < ActiveRecord::Migration[8.1]
  def change
    add_column :places, :user_id, :integer
  end
end
