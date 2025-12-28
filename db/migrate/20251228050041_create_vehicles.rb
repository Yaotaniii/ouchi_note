class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.references :resident, null: false, foreign_key: true
      t.string :vehicle_type, null: false
      t.string :make_model
      t.string :plate_number

      t.timestamps
    end
  end
end