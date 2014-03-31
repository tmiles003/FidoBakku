class GoalSerializer < ActiveModel::Serializer
  attributes :id, :content, :goal_path
  
  def goal_path
    root_path(anchor: goal_manage_path(object))
  end
end
