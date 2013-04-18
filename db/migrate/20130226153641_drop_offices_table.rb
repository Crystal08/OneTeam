class DropOfficesTable < ActiveRecord::Migration
  def up
    drop_table :offices	    
  end

  def down
    create_table :offices do |t|
      t.string :name

      t.timestamps
  end
  end  
end
