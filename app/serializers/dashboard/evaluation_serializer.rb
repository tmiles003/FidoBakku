class Dashboard::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :name, :email_hash, :team_id, :evaluation_path
  
  def name
    object.user.name
  end
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.user.email).hexdigest
  end
  
  def team_id
    object.user.team.id unless object.user.team.nil?
  end
  
  def evaluation_path
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
