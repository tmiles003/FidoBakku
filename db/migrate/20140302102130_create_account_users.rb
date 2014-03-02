class CreateAccountUsers < ActiveRecord::Migration
  def change
    create_table :account_users do |t|
      t.references :account, index: true
      t.references :user, index: true, :unique => true

      #t.timestamps
    end
  end
end
