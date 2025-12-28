class CreateBicycleRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :bicycle_registrations do |t|
      t.references :resident, null: false, foreign_key: true
      t.string :registration_number, null: false
      t.integer :bicycle_count, default: 1

      t.timestamps
    end

    add_index :bicycle_registrations, :registration_number, unique: true
  end
end