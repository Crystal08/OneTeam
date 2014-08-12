class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :employee_id
      t.string :task
      t.string :skills_needed
      t.string :location
      t.string :dates
      t.string :group
      t.string :lead
      t.string :contact

      t.timestamps
    end
  end
end
