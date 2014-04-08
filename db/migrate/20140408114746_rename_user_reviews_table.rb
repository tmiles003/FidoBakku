class RenameUserReviewsTable < ActiveRecord::Migration
  def change
    rename_table :user_reviews, :user_evaluations
    
    rename_column :user_evaluations, :review_id, :evaluation_id
  end
end
