class AddEmbedHtmlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :embed_html, :string
  end
end
