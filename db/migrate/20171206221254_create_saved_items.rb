class CreateSavedItems < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_items do |t|
      t.references :users, foreign_key: true
      t.string :title
      t.string :img
      t.string :price
      t.string :url

      t.timestamps
    end
  end
end
