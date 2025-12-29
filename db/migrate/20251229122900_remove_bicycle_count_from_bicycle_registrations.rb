class RemoveBicycleCountFromBicycleRegistrations < ActiveRecord::Migration[7.1]
  def change
    remove_column :bicycle_registrations, :bicycle_count, :integer
  end
end