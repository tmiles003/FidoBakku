class Dashboard::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :feedback_path
  has_one :user
  
  def feedback_path
    root_path(anchor: evaluation_feedback_path(object))
  end
  
  # , :due_date, :due_date_ts
  
  def due_date
    object.due_date.strftime('%e %B %Y').strip unless object.due_date.nil?
  end
  
  def due_date_ts
    object.due_date.strftime('%s') unless object.due_date.nil?
  end
  
end
