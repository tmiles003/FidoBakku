class Admin::EvaluationSession::UserSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :team_id
  
  def id
    object.user.id
  end
  
  def name
    object.user.name
  end
  
  def team_id
    object.user.team.nil? ? nil : object.user.team.id
  end
  
end
