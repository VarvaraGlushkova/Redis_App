class AddParametersToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :slug, :string
    add_column :posts, :published_at, :datetime
  end
end
