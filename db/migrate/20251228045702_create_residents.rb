class CreateResidents < ActiveRecord::Migration[7.1]
  def change
    create_table :residents do |t|
      t.references :room, null: false, foreign_key: true
      t.string :name, null: false
      t.string :phone
      t.string :email
      t.string :emergency_contact
      t.date :move_in_date, null: false
      t.date :move_out_date
      t.boolean :has_pet, default: false
      t.string :pet_details
      t.integer :occupants_count, default: 1
      t.text :notes

      t.timestamps
    end
  end
end