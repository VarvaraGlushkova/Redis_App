class AddForeignKeyToProfiles < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :profiles, :users, on_delete: :cascade
  end
end
