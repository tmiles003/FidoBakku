class EvaluationSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :created_at, :evaluation_path
  
  def created_at
    object.created_at.strftime('%s') unless object.created_at.nil?
  end
  
  def evaluation_path
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
