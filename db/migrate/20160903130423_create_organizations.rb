class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :owner_identifier, null: false

      t.timestamps
    end
    add_index :organizations, :name, unique: true
    add_index :organizations, :owner_identifier
  end
end
