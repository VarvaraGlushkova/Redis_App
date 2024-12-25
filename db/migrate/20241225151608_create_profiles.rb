class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :bio
      t.string :avatar
      t.integer :user_id

      t.timestamps
    end
  end
end
