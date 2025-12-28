class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts do |t|
      t.references :resident, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date
      t.string :guarantor_name
      t.string :guarantor_phone
      t.string :guarantor_address
      t.integer :deposit, default: 0
      t.integer :key_money, default: 0
      t.integer :deposit_returned
      t.text :notes

      t.timestamps
    end
  end
end