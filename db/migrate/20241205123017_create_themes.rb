class CreateThemes < ActiveRecord::Migration[7.2]
  def change
    create_table :themes do |t|
      t.string :theme_title
      t.string :theme_descr
      t.string :theme_image

      t.timestamps
    end
  end
end
