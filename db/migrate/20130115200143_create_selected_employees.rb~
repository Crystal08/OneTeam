class CreateSelectedEmployees < ActiveRecord::Migration
  def change
    create_table :selected_employees do |t|
      t.string :name
      t.integer :employee_id
      t.integer :request_id
      t.integer :response_id
      t.string :notes

      t.timestamps
    end
  end
end
