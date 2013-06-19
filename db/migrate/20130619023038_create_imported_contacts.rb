class CreateImportedContacts < ActiveRecord::Migration
  def change
    create_table :imported_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.integer :referer_id

      t.timestamps
    end

    add_index :imported_contacts, :email, unique: true
  end
end
