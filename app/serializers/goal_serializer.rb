class GoalSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :content, :due_date, :due_date_ts, :is_private, :is_complete, :goal_path
  
  def due_date
    object.due_date.strftime('%d/%m/%Y') unless object.due_date.nil?
  end
  
  def due_date_ts
    object.due_date.strftime('%s') unless object.due_date.nil?
  end
  
  def goal_path
    root_path(anchor: goal_manage_path(object))
  end
end
