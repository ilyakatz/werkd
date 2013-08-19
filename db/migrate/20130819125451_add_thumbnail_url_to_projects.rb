class AddThumbnailUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :thumbnail_url, :string
    remove_column :projects, :embed_url
  end
end
