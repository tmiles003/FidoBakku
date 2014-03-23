class AddOwnerToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :owner_id, :integer, :after => :email
  end
end
