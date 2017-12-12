class CreateSavedItems < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_items do |t|
      t.belongs_to :user
      t.string :title
      t.string :img
      t.string :price
      t.string :url

      t.timestamps
    end
  end
end
