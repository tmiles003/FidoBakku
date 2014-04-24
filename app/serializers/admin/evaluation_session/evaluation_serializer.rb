class Admin::EvaluationSession::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :manage_path, :name, :team_id
  
  def manage_path
    root_path(anchor: admin_evaluation_manage_path(object))
  end
  
  def name
    object.user.name
  end
  
  def team_id
    object.user.team.nil? ? nil : object.user.team.id
  end
  
end
