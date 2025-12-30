class AddParkingFeesToResidents < ActiveRecord::Migration[7.1]
  def change
    add_column :residents, :parking_fee, :integer
    add_column :residents, :bicycle_fee, :integer
    add_column :residents, :motorcycle_fee, :integer
  end
end
