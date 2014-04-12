class RenameScoresColumnToRatings < ActiveRecord::Migration
  def change
    rename_column :user_evaluations, :scores, :ratings
  end
end
