class AddStartAtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :start_at, :date
  end
end
