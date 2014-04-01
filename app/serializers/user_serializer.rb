class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :role, :team_id, :user_path
  
  def team_id
    object.team.nil? ? nil : object.team.id
  end
  
  def user_path
    root_path(anchor: user_manage_path(object))
  end
  
end
