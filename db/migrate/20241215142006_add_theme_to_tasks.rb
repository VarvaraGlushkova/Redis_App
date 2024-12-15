class AddThemeToTasks < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :theme, null: true, foreign_key: true
  end
end
