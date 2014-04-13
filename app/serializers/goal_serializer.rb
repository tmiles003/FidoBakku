class GoalSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :content, :private, :done, :goal_path
  has_one :user
  
  def due_date
    object.due_date.strftime('%e %B %Y').strip unless object.due_date.nil?
  end
  
  def due_date_ts
    object.due_date.strftime('%s') unless object.due_date.nil?
  end
  
  def due_date_parts
    unless object.due_date.nil?
      p = Hash.new
      p['d'] = object.due_date.strftime('%e').strip
      p['m'] = object.due_date.strftime('%b')
      p['y'] = object.due_date.strftime('%Y')
      p
    end
  end
  
  def goal_path
    root_path(anchor: goal_manage_path(object))
  end
end
