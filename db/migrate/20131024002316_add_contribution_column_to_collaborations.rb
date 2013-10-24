class AddContributionColumnToCollaborations < ActiveRecord::Migration
  def change
    change_table :collaborations do |t|
      t.string :contribution
    end
  end
end
