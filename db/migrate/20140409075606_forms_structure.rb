class FormsStructure < ActiveRecord::Migration
  def change
    rename_column :forms, :component, :shared
    remove_column :forms, :parent
    
    create_table :form_parts do |t|
      t.integer :form_id
      t.integer :part_id
      
    end
    add_index :form_parts, [:form_id, :part_id], :unique => true
    
  end
end
