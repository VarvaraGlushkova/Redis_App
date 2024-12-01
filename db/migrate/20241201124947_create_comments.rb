class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :user_name_title
      t.text :body_content

      t.timestamps
    end
  end
end
