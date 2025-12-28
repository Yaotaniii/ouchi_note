class CreateRentHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :rent_histories do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :rent, null: false
      t.date :started_on, null: false
      t.text :notes

      t.timestamps
    end
  end
end