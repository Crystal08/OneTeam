class RemoveNameFromSelections < ActiveRecord::Migration
  def up
    remove_column :selections, :name
  end

  def down
    add_column :selections, :name, :string
  end
end
