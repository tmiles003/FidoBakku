class AddTypeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :plan, :string, :after => :name
  end
end
