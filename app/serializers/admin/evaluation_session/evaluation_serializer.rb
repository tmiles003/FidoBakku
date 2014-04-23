class Admin::EvaluationSession::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :manage_path, :name
  
  def manage_path
    root_path(anchor: admin_evaluation_manage_path(object))
  end
  
  def name
    object.user.name
  end
  
end
