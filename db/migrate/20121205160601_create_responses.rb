class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :request_id
      t.integer :employee_id
      t.string :comments

      t.timestamps
    end
  end
end
