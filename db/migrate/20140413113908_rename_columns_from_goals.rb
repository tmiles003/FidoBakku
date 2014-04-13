class RenameColumnsFromGoals < ActiveRecord::Migration
  def change
    remove_column :goals, :due_date
    
    rename_column :goals, :is_private, :private
    rename_column :goals, :is_complete, :done
  end
end
