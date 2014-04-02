class AddColumnsToForm < ActiveRecord::Migration
  def change
    add_column :forms, :component, :boolean, :after => :name
    add_column :forms, :parent, :integer, :after => :component
  end
end
