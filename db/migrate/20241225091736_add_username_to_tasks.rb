class AddUsernameToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :username, :string
  end
end
