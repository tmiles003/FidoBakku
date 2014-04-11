class AddMissingEvaluationColumns < ActiveRecord::Migration
  def change
    # move form_id from user_evaluations to evaluations, for feedback consistency
    remove_column :user_evaluations, :form_id
    remove_column :user_evaluations, :user_id
    #add_column :user_evaluations, :done, :boolean, :after => :progress
    
    add_column :evaluation_sessions, :evals, :boolean, :after => :title
    add_column :evaluation_sessions, :done, :boolean, :after => :evals
    
    add_column :evaluations, :form_id, :integer, :after => :user_id
    add_column :evaluations, :rating, :integer, :after => :form_id
    add_column :evaluations, :done, :boolean, :after => :rating
    
  end
end
