class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :image
      t.string :name
      t.string :price
      t.string :content
      t.string :item_code

      t.timestamps
    end
  end
end
