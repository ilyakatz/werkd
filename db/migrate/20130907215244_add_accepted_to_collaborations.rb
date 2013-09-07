class AddAcceptedToCollaborations < ActiveRecord::Migration
  def change
    add_column :collaborations, :accepted_at, :datetime
  end
end
