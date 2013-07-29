class AddEmbedUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :embed_url, :string
  end
end
