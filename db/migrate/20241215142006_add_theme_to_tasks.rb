class AddThemeToTasks < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :theme, null: false, foreign_key: true
  end
end
