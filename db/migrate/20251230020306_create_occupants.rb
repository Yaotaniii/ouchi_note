class CreateOccupants < ActiveRecord::Migration[7.1]
  def change
    create_table :occupants do |t|
      t.references :resident, null: false, foreign_key: true
      t.string :name
      t.string :name_furigana
      t.string :relation

      t.timestamps
    end
  end
end
