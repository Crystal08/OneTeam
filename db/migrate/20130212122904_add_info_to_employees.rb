class AddInfoToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :about_me, :string
    add_column :employees, :image, :string
  end
end
