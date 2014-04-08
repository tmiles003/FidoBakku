class CreateEvaluationSessions < ActiveRecord::Migration
  def change
    create_table :evaluation_sessions do |t|
      t.integer :account_id
      t.string :title

      t.timestamps
    end
  end
end
