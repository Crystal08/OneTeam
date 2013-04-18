class RemoveLeadandContactfromRequests < ActiveRecord::Migration
  def up
    remove_column :requests, :lead
    remove_column :requests, :contact
  end

  def down
    add_column :requests, :lead, :string
    add_column :reqeusts, :contact, :string
  end
end
