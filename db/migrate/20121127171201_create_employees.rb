class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.decimal :years_with_company
      t.string :manager
      t.string :position
      t.string :department
      t.string :group
      t.string :location
      t.string :current_skills
      t.string :skills_interested_in

      t.timestamps
    end
  end
end
