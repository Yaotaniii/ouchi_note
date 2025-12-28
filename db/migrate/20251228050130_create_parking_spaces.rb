class CreateParkingSpaces < ActiveRecord::Migration[7.1]
  def change
    create_table :parking_spaces do |t|
      t.string :space_number, null: false
      t.string :user_type, null: false, default: 'resident'
      t.references :resident, null: true, foreign_key: true
      t.text :notes

      t.timestamps
    end

    add_index :parking_spaces, :space_number, unique: true
  end
end