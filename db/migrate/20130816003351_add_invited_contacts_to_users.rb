class AddInvitedContactsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invited_contacts, :datetime, default: nil
  end
end
