class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :room_number, null: false
      t.string :floor_plan
      t.integer :rent
      t.string :status, null: false, default: 'vacant'
      t.text :notes

      t.timestamps
    end

    add_index :rooms, :room_number, unique: true
  end
end