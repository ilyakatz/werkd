class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :connected_to

      t.timestamps
    end

    add_index :connections, [:user_id, :connected_to], unique: true
  end
end
