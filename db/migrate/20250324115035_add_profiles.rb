class AddProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true # Foreign key to User
      t.string :name
      t.text :bio
      t.string :avatar
    end
  end
end
