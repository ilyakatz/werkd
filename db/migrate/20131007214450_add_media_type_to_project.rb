class AddMediaTypeToProject < ActiveRecord::Migration
  def change
    add_column :projects, :media_type, :string
  end
end
