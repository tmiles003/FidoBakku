class GoalSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :due_date, :is_private, :is_complete, :goal_path
  
  def due_date
    object.due_date = object.due_date.strftime('%d/%m/%Y') unless object.due_date.nil?
  end
  
  def goal_path
    root_path(anchor: goal_manage_path(object))
  end
end
