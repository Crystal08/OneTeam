class RemoveSkillsInterestedInFromEmployee < ActiveRecord::Migration
  def up
    remove_column :employees, :skills_interested_in
  end

  def down
    add_column :employees, :skills_interested_in, :string
  end
end
