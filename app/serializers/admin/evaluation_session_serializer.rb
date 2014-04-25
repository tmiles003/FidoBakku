class Admin::EvaluationSessionSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :created_at, :manage_path
  #, :num_evaluations
  
  def created_at
    object.created_at.strftime('%s') unless object.created_at.nil?
  end
  
  def manage_path
    root_path(anchor: admin_session_manage_path(object))
  end
  
  def num_evaluations
    object.evaluations.count
  end
  
end
