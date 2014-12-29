class AddWatchingToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :watching, :boolean
  end
end
