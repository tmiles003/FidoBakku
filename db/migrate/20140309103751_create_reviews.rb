class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :account_id
      t.string :title
      t.boolean :open
      t.boolean :archived

      t.timestamps
    end
  end
end
