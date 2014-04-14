class AddEvaluationIdToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :evaluation_id, :integer, :after => :user_id
  end
end
