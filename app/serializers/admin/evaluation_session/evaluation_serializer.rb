class Admin::EvaluationSession::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :manage_path
  has_one :user, serializer: ::Admin::EvaluationSession::EvaluationUserSerializer
  
  def manage_path
    root_path(anchor: admin_evaluation_manage_path(object))
  end
  
end
