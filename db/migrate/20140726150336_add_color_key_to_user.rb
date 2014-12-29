class AddColorKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :color_key, :integer
  end
end
