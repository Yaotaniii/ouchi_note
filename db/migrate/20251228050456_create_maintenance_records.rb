class CreateMaintenanceRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :maintenance_records do |t|
      t.references :room, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.date :performed_on, null: false
      t.integer :cost, default: 0

      t.timestamps
    end
  end
end