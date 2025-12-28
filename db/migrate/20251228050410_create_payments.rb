class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :resident, null: false, foreign_key: true
      t.string :year_month, null: false
      t.integer :amount, null: false
      t.date :paid_on
      t.string :status, null: false, default: 'unpaid'
      t.text :notes

      t.timestamps
    end

    add_index :payments, [:resident_id, :year_month], unique: true
  end
end