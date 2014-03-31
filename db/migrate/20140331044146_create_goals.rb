class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.text :content
      t.date :due_date
      t.boolean :private
      t.boolean :complete

      #t.timestamps
      t.datetime :created_at
    end
  end
end
