class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :referer_id
      t.integer :user_id

      t.timestamps
    end

    add_index :invitations, [:email, :referer_id], unique: true
  end
end
