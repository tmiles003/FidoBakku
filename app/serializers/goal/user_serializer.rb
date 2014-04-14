class Goal::UserSerializer < BaseUserSerializer
  
  def attributes
    hash = super
    hash.delete(:id)
    hash.delete(:email)
    hash.delete(:user_path)
    
    hash
  end
  
end
