class UpdateEvaluationsColumns < ActiveRecord::Migration
  def change
    
    remove_column :reviews, :title
    remove_column :reviews, :status
    remove_column :reviews, :updated_at
    
    rename_table :reviews, :evaluations
    
    add_column :evaluations, :user_id, :integer, :after => :account_id
    add_column :evaluations, :visible, :boolean, :after => :user_id
    add_column :evaluations, :editable, :boolean, :after => :visible
    
  end
end
