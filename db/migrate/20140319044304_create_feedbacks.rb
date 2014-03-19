class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :review_id
      t.text :content

      t.timestamps
    end
  end
end
