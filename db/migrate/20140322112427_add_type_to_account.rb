class AddTypeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :type, :string, :after => :name
  end
end
