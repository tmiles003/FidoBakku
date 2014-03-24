class AddStatusToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :status, :string, :after => :title
    remove_column :reviews, :open
    remove_column :reviews, :archived
  end
end
