class AddManagementFeeToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :management_fee, :integer
  end
end
