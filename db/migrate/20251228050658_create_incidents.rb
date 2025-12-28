class CreateIncidents < ActiveRecord::Migration[7.1]
  def change
    create_table :incidents do |t|
      t.references :resident, null: false, foreign_key: true
      t.references :room, null: true, foreign_key: true
      t.string :incident_type, null: false, default: 'other'
      t.string :title, null: false
      t.text :description
      t.date :occurred_on, null: false
      t.date :resolved_on
      t.string :status, null: false, default: 'open'

      t.timestamps
    end
  end
end