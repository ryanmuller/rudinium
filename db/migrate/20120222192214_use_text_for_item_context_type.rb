class UseTextForItemContextType < ActiveRecord::Migration
  def up
    change_column :items, :content, :text
  end

  def down
    change_colum :items, :content, :string
  end
end
