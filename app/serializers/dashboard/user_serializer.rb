class Dashboard::UserSerializer < BaseUserSerializer
  
  attributes :name, :email_hash, :user_path, :team_id
  
  def team_id
    object.team.nil? ? nil : object.team.id
  end
  
end
