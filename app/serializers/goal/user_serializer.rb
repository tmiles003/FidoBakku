class Goal::UserSerializer < BaseUserSerializer
  
  def attributes
    hash = super
    hash.delete(:id)
    hash.delete(:email)
    
    hash
  end
  
end
