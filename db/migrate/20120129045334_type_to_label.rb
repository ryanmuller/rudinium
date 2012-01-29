class TypeToLabel < ActiveRecord::Migration
  def change
    rename_column :items, :type, :label
  end
end
