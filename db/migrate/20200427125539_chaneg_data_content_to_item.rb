class ChanegDataContentToItem < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :content, :text
  end
end
