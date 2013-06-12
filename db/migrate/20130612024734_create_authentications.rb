class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :provider_id
      t.integer :user_id

      t.timestamps
    end

    add_index :authentications, [:provider, :user_id], unique: true
  end
end
