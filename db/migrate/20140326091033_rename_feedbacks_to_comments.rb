class RenameFeedbacksToComments < ActiveRecord::Migration
  def change
    rename_table :feedbacks, :comments
  end
end
