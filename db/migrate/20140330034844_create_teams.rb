class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :account_id
      t.string :name

      #t.timestamps
    end
    
    create_table :team_users do |t|
      t.references :team, index: true
      t.references :user, index: true, :unique => true
    end
  end
end
