class AddContributionsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :contribution, :string
  end
end
