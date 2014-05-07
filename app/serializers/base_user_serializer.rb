class BaseUserSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :email, :email_hash, :team_id, :user_path
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.email).hexdigest
  end
  
  def team_id
    object.team.id unless object.team.nil?
  end
  
  def user_path
    root_path(anchor: user_manage_path(object))
  end
  
end
