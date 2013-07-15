class AddSentAtToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :sent_at, :time
    add_column :connections, :accepted_at, :time
  end
end
