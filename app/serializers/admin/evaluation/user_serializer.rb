class Admin::Evaluation::UserSerializer < BaseUserSerializer
  
  attributes :id, :name, :team_id
  
  def attributes
    hash = super
    hash.delete(:email)
    hash.delete(:email_hash)
    hash.delete(:user_path)
    
    hash
  end
  
  def team_id
    object.team.nil? ? nil : object.team.id
  end
  
end
