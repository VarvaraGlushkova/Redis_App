class AddImageToThemes < ActiveRecord::Migration[7.2]
  def change
    add_column :themes, :theme_cover, :string
  end
end
