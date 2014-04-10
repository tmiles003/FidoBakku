class RenameReviewerColumn < ActiveRecord::Migration
  def change
    rename_column :user_evaluations, :reviewer_id, :evaluator_id
    rename_column :user_evaluations, :reviewer_name, :evaluator_name
  end
end
