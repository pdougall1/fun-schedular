class CreateInclusions < ActiveRecord::Migration
  def change
    create_table :inclusions do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :status

      t.timestamps
    end
  end
end
