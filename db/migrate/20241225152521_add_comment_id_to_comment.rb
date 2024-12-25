class AddCommentIdToComment < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :comment_id, :integer
  end
end
