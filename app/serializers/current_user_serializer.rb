class CurrentUserSerializer < ActiveModel::Serializer
  attributes :name, :email_hash
  #:id, , :user_path
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.email).hexdigest
  end
  
  def user_path
    root_path(anchor: user_manage_path(object))
  end
  
end
