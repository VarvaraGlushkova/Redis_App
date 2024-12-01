class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.string :user_name
      t.string :description
      t.string :answer_img

      t.timestamps
    end
  end
end
