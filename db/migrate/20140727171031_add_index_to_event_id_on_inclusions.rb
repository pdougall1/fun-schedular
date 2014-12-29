class AddIndexToEventIdOnInclusions < ActiveRecord::Migration
  def change
  	add_index :inclusions, :event_id
  end
end
