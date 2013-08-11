class AddIndexToTagging < ActiveRecord::Migration
  def change
    add_index :taggings, [:tag_id, :taggable_id, :taggable_type, :tagger_id, :tagger_type, :context], unique: true, name: :tagging_index
  end
end
