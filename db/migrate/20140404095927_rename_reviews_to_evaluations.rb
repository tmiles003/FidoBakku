class RenameReviewsToEvaluations < ActiveRecord::Migration
  def change
    rename_table :reviews, :evaluations
  end
end
