class CreateUserReviews < ActiveRecord::Migration
  def change
    create_table :user_reviews do |t|
      t.integer :review_id
      t.integer :user_id
      t.integer :form_id
      t.integer :reviewer_id
      t.string :reviewer_name
      t.text :scores

      t.timestamps
    end
  end
end
