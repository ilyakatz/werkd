class ChangeDataTypeForEmbedHtml < ActiveRecord::Migration
  def change
    change_column :projects, :embed_html, :text
  end
end
