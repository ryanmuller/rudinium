class AddSerializedItemInfo < ActiveRecord::Migration
  def up
    add_column :items, :item_info, :text
  end

  def down
    remove_column :items, :item_info
  end
end
