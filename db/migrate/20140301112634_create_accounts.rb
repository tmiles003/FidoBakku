class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :name
      t.string :key
      t.date :expires_at

      t.timestamps
    end
    add_index :accounts, :email, unique: true
  end
end
