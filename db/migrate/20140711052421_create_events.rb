class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.date :date
      t.datetime :time
      t.integer :user_id

      t.timestamps
    end
  end
end
