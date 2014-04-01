class AddTitleToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :title, :string, :after => :user_id
  end
end
