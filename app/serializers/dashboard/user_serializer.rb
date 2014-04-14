class Dashboard::UserSerializer < BaseUserSerializer
  
  attributes :name, :email_hash, :user_path
  
end
