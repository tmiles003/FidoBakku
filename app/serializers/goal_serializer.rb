class GoalSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :due_date, :is_private, :is_complete, :goal_path
  
  def is_private
    object.is_private ? 1 : 0
  end
  
  def is_complete
    object.is_complete ? 1 : 0
  end
  
  def goal_path
    root_path(anchor: goal_manage_path(object))
  end
end
