class CreateRoomVacancies < ActiveRecord::Migration[7.1]
  def change
    create_table :room_vacancies do |t|
      t.references :room, null: false, foreign_key: true
      t.date :vacant_from, null: false
      t.date :vacant_until

      t.timestamps
    end
  end
end