class Dashboard::GoalSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :goal_path, :due_date_ts
  
  def goal_path
    root_path(anchor: goal_manage_path(object))
  end
  
  def due_date_ts
    object.due_date.strftime('%s') unless object.due_date.nil?
  end
  
end
