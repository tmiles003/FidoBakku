class GoalSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :due_date, :is_private, :is_complete, :goal_path
  
  def goal_path
    root_path(anchor: goal_manage_path(object))
  end
end
