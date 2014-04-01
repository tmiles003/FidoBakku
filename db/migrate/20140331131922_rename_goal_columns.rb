class RenameGoalColumns < ActiveRecord::Migration
  def change
    rename_column(:goals, :private, :is_private)
    rename_column(:goals, :complete, :is_complete)
    
    change_column_default(:goals, :is_private, 0)
    change_column_default(:goals, :is_complete, 0)
  end
end
