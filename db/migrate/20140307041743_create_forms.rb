class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.integer :account_id
      t.string :name

      t.timestamps
    end
  end
end
