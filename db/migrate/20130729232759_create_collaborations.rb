class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :user_id
      t.integer :project_id
      t.timestamps
    end

    add_index :collaborations, [:user_id, :project_id], unique: true
  end
end
