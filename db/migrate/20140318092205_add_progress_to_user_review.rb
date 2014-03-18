class AddProgressToUserReview < ActiveRecord::Migration
  def change
    add_column :user_reviews, :progress, :integer, :after => :scores
  end
end
