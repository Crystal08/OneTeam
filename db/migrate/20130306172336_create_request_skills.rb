class CreateRequestSkills < ActiveRecord::Migration
  def change
    create_table :request_skills do |t|
      t.integer :skill_id
      t.integer :request_id

      t.timestamps
    end
  end
  
 
end
