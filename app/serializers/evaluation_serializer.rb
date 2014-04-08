class EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :user_id, :created_at, :manage_path
  has_one :user
  
  def user
    #object.user.where(id: scope)
    ::User.find(object.user_id)
  end
  
  def created_at
    object.created_at.strftime('%s') unless object.created_at.nil?
  end
  
  def manage_path
    root_path(anchor: evaluation_manage_path(object))
  end
  
  # , :due_date, :due_date_ts
  
  def due_date
    object.due_date.strftime('%e %B %Y').strip unless object.due_date.nil?
  end
  
  def due_date_ts
    object.due_date.strftime('%s') unless object.due_date.nil?
  end
  
end
