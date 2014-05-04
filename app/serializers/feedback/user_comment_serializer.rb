class Feedback::UserCommentSerializer < ActiveModel::Serializer
  
  attributes :content, :name, :email_hash
  
  def name
    object.user.name unless object.user.nil?
  end
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.user.email).hexdigest unless object.user.nil?
  end
  
end
