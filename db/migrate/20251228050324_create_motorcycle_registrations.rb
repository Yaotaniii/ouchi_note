class CreateMotorcycleRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :motorcycle_registrations do |t|
      t.references :resident, null: false, foreign_key: true
      t.string :registration_number, null: false

      t.timestamps
    end

    add_index :motorcycle_registrations, :registration_number, unique: true
  end
end