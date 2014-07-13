class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
    add_column :events, :begin_time, :datetime
    add_column :events, :end_time, :datetime
    add_column :events, :description, :text
  end
end
