class UserEvaluationUserSerializer < ActiveModel::Serializer
  attributes :email_hash, :name
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.email).hexdigest
  end
  
end
