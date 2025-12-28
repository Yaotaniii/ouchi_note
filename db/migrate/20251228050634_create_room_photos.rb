class CreateRoomPhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :room_photos do |t|
      t.references :room, null: false, foreign_key: true
      t.string :photo_type, null: false
      t.date :taken_on

      t.timestamps
    end
  end
end