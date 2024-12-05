class DropThemes < ActiveRecord::Migration[7.2]
  def change
    drop_table :themes
  end
end
