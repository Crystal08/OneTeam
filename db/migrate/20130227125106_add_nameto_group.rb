class AddNametoGroup < ActiveRecord::Migration
  def up
   add_column :groups, :name, :string

 
  end

  def down
  	drop_column :groups, :name, :string
  end
end
