class CreateActivityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.string :target_type
      t.string :target_name
      t.text :details

      t.timestamps
    end
  end
end
