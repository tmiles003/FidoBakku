class AddColumnsToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :updated_at
    
    add_column :comments, :user_id, :integer, :after => :review_id
    add_column :comments, :evaluation_id, :integer, :after => :user_id
    add_column :comments, :goal_id, :integer, :after => :evaluation_id
    add_column :comments, :user_evaluation_id, :integer, :after => :goal_id
    
    remove_column :comments, :review_id
  end
end
