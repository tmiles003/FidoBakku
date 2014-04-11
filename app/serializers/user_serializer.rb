class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email_hash, :user_path
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.email).hexdigest
  end
  
  def user_path
    root_path(anchor: user_manage_path(object))
  end
  
end
