class AddStatusToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :status, :string
  end
end
