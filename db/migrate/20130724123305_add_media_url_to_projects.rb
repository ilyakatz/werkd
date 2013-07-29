class AddMediaUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :media_url, :string
  end
end
