class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :company
      t.integer :user_id
      t.string :video

      t.timestamps
    end
  end
end
