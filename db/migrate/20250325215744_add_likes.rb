class AddLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :likeable, polymorphic: true, index: true
      t.timestamps
    end

    # Add uniqueness constraint to prevent duplicate likes
    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true
  end
end
