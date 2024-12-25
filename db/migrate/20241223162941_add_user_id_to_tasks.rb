class AddUserIdToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :user_id, :integer
  end
end
