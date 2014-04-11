class Dashboard::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :user, :feedback_path
  # has_one :user
  
  def user
    #::User.find(object.user_id)
    ::User.select('name, MD5(email) AS email_hash').find(object.user_id)
  end
  
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
