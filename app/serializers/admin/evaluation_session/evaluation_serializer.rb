class Admin::EvaluationSession::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :manage_path, :name, :email_hash, :team_id
  
  def manage_path
    root_path(anchor: admin_evaluation_manage_path(object))
  end
  
  def name
    object.user.name
  end
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.user.email).hexdigest
  end
  
  def team_id
    object.user.team.nil? ? nil : object.user.team.id
  end
  
end
