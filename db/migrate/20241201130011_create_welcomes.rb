class CreateWelcomes < ActiveRecord::Migration[7.2]
  def change
    create_table :welcomes do |t|
      t.timestamps
    end
  end
end
