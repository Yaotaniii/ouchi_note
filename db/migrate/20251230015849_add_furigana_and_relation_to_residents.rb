class AddFuriganaAndRelationToResidents < ActiveRecord::Migration[7.1]
  def change
    add_column :residents, :name_furigana, :string
    add_column :residents, :emergency_contact_relation, :string
  end
end
