class CreateUserInvites < ActiveRecord::Migration
  def change
    create_table :user_invites do |t|
      t.string :token
      t.datetime :used_at

      t.timestamps
    end
  end
end
