class AddAnswerToComments < ActiveRecord::Migration[7.2]
  def change
    add_reference :comments, :answer, null: false, foreign_key: true
  end
end
