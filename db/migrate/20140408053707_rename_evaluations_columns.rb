class RenameEvaluationsColumns < ActiveRecord::Migration
  def change
    rename_column(:evaluations, :account_id, :session_id)
    
    remove_column :evaluations, :visible
    remove_column :evaluations, :editable
  end
end
